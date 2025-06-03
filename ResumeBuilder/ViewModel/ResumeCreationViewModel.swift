//
//  ResumeCreationViewModell.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 23.01.2025.
//

import Foundation
import UIKit
import SwiftUI
import PDFKit

class ResumeCreationViewModel : ObservableObject {
    
    @Published var resume = ResumeCreationModel(template: "",
                                                name: "", // req
                                                title: "", // req
                                                phone: "", // vse ravno
                                                email: "", // vse ravno
                                                site: "", // vse ravno
                                                address: "", // vse ravno
                                                about_me: "", // req
                                                skills: [Skill(name: "", level: 20)], //req
                                                experience: [ExperienceModel(company: "", position: "", description: "", startWork: formatDate(date: Date()), finishWork: nil)], // vse ravno
                                                education: [EducationModel(name: "", description: "", specialty: "", startSchool: formatDate(date: Date()), finishSchool: formatDate(date: Date()))], // vse ravno
                                                photo: "", // vse ravno
                                                projects: [ProjectModel(name: "", description: "")], // vse ravno
                                                language: [LanguageModel(name: "")], // vse ravno
                                                interests: [InterestsModel(name: "")] // vse ravno
    )
    let templates : [TemplateModel] = [
        TemplateModel(num: "1", isPrem: false),
        TemplateModel(num: "2", isPrem: true),
        TemplateModel(num: "3", isPrem: true)
    ]
    
    @Published var startedCreation = false
    
    @Published var result : ResumeCreationResponse?
    @Published var pdfData : Data?
    
    @Published var showAlert = false
    @Published var alertText = ""
    
    
    @Published var eduStartDate : [Date] = [Date()]
    @Published var eduEndDate : [Date] = [Date()]
    
    
    @Published var expStartDate : [Date] = [Date()]
    @Published var expEndDate : [Date] = [Date()]
    @Published var expStillWorks : [Bool] = [false]
    @Published var noWorkExp = false
    
    @Published var pdfHistoryURLS : [URL] = []
    
    @Published var pdfIsReady = false
    
    @Published var emailIsWrong = false
    
    @Published var infoFirstName = ""
    @Published var infoLastName = ""
    
    init() {
        getAllSavedPDFs()
    }
    
    func createResume() {
        startedCreation = true
        guard let url = URL(string: "https://resbuuldr.fun/api/generate-resume") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(resume)
            request.httpBody = jsonData
        } catch {
            print("Failed to encode model: \(error)")
        }
        
        let task = URLSession.shared.dataTask(with: request){data, resp, error in
            guard let data = data, error == nil else {
                print(error as Any)
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(ResumeCreationResponse.self, from: data)
                DispatchQueue.main.async {
                    self.result = decodedData
                    print(decodedData)
                    Task{
                        await self.loadPDFFromUrl()
                    }
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    func convertImageToBase64String(image: UIImage) -> String? {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return nil }
        return "data:image/jpeg;base64," + imageData.base64EncodedString()
    }
    
    func loadPDFFromUrl() async -> Data? {
        do {
            guard let res = result else {return nil}
            guard let url = URL(string: res.url) else {return nil}
            let (data, _) = try await URLSession.shared.data(from: url)
            DispatchQueue.main.async {
                self.pdfData = data
            }
            await savePDFToLocal(data: data)
            return data
        } catch {
            print("Error loading PDF: \(error)")
            return nil
        }
    }
    
//    func getThumbnailFromPDF(document : PDFDocument) async {
//        do{
//            let renderedImage = try await Task.detached(priority: .userInitiated) {
//                // Get first page
//                guard let page = document.page(at: 0) else {
//                    throw NSError(domain: "No pages in PDF", code: 1)
//                }
//                
//                // Calculate page size and scale (adjust scale as needed)
//                let pageRect = page.bounds(for: .mediaBox)
//                let scale: CGFloat = 2.0 // Use 0.5 for 50% scale
//                let scaledSize = CGSize(
//                    width: pageRect.width * scale,
//                    height: pageRect.height * scale
//                )
//                
//                // Render the page as an image
//                let image = UIGraphicsImageRenderer(size: scaledSize).image { ctx in
//                    // Fill background (optional)
//                    UIColor.white.setFill()
//                    ctx.fill(CGRect(origin: .zero, size: scaledSize))
//                    
//                    // Flip and scale the context
//                    let cgContext = ctx.cgContext
//                    cgContext.translateBy(x: 0, y: scaledSize.height)
//                    cgContext.scaleBy(x: scale, y: -scale)
//                    
//                    // Draw the page
//                    page.draw(with: .mediaBox, to: cgContext)
//                }
//                
//                return image
//            }.value
//            
//            // Update image on main thread
//            await MainActor.run {
//                pdfThumbnail = renderedImage
//                self.startedCreation = false
//            }
//            
//            
//        }catch {
//            print(error.localizedDescription)
//        }
//        
//        
//    }
    
    func containsAtAndCharAfter(_ string: String) -> Bool {
        // Find the first occurrence of "@"
        guard let atIndex = string.firstIndex(of: "@") else {
            return false
        }
        // Check if there's at least one character after the "@"
        let afterAt = string.index(after: atIndex)
        return afterAt < string.endIndex
    }
    
    func canGenerate() -> Bool {
        return !resume.template.isEmpty &&
        !resume.email.isEmpty &&
        containsAtAndCharAfter(resume.email) &&
        !resume.name.isEmpty &&
        !resume.title.isEmpty &&
        !resume.about_me.isEmpty &&
        resume.skills.allSatisfy {
            !$0.name.isEmpty
        } &&
        resume.experience.allSatisfy {
            !$0.company.isEmpty &&
            !$0.position.isEmpty &&
            !$0.description.isEmpty &&
            !$0.startWork.isEmpty
        } &&
        resume.education.allSatisfy {
            !$0.name.isEmpty &&
            !$0.specialty.isEmpty &&
            !$0.startSchool.isEmpty &&
            !$0.finishSchool.isEmpty
        } &&
        resume.projects.allSatisfy {
            !$0.name.isEmpty &&
            !$0.description.isEmpty
        } &&
        resume.language.allSatisfy {
            !$0.name.isEmpty
        } &&
        resume.interests.allSatisfy {
            !$0.name.isEmpty
        }
    }
    
    func convertPDFToImages() -> [UIImage] {
        guard let pdfData = pdfData else { return [] }
        guard let document = PDFDocument(data: pdfData) else { return [] }
        
        var images: [UIImage] = []
        
        for i in 0..<document.pageCount {
            guard let page = document.page(at: i) else { continue }
            
            let pageRect = page.bounds(for: .mediaBox)
            let renderer = UIGraphicsImageRenderer(size: pageRect.size)
            
            let image = renderer.image { context in
                UIColor.white.setFill()
                context.fill(pageRect)
                
                let cgContext = context.cgContext
                
                // **Fix the orientation**
                cgContext.translateBy(x: 0, y: pageRect.height)
                cgContext.scaleBy(x: 1.0, y: -1.0) // Flips the coordinate system

                page.draw(with: .mediaBox, to: cgContext)
            }
            
            images.append(image)
        }
        
        return images
    }
    
    private func savePDFToLocal(data: Data) async{
        let fileManager = FileManager.default
        let fileName = "Created at \(Date()).pdf"
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let pdfsDirectory = documentsDirectory.appendingPathComponent("PDFs")
        
        // Ensure the "PDFs" directory exists
        if !fileManager.fileExists(atPath: pdfsDirectory.path) {
            do {
                try fileManager.createDirectory(at: pdfsDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating PDFs directory: \(error)")
            }
        }
        let fileURL = pdfsDirectory.appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL)
            DispatchQueue.main.async{
                self.pdfHistoryURLS.append(fileURL)
                self.startedCreation = false
                self.pdfIsReady = true
            }
            print("Saved")
        } catch {
            print("Error saving PDF: \(error)")
        }
    }
    
    
    func getAllSavedPDFs() {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let pdfsDirectory = documentsDirectory.appendingPathComponent("PDFs")

        do {
            // Ensure the directory exists
            guard fileManager.fileExists(atPath: pdfsDirectory.path) else {
                print("PDFs directory does not exist.")
                DispatchQueue.main.async {
                    self.pdfHistoryURLS = []
                }
                
                return
            }
            
            // Get all files in the "PDFs" directory
            let fileURLs = try fileManager.contentsOfDirectory(at: pdfsDirectory, includingPropertiesForKeys: nil)
            
            // Filter only PDF files
            let pdfFiles = fileURLs.filter { $0.pathExtension.lowercased() == "pdf" }
            
            DispatchQueue.main.async {
                self.pdfHistoryURLS = pdfFiles
                
            }
            
        } catch {
            print("Error retrieving PDFs: \(error)")
            DispatchQueue.main.async {
                self.pdfHistoryURLS = []
            }
        }
    }
    
    func deletePDF(at url: URL) {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(at: url)
            print("Deleted PDF: \(url.lastPathComponent)")
            DispatchQueue.main.async {
                if let id = self.pdfHistoryURLS.firstIndex(of: url){
                    self.pdfHistoryURLS.remove(at: id)
                }
            }
        } catch {
            print("Error deleting PDF: \(error)")
        }
    }
}

