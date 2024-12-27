import SwiftUI
import PDFKit

struct PDFGenerator {
    static func createPDF(from text: String, fileName: String = "GeneratedPDF") -> URL? {
        // Create an attributed string from the input text
        let attributedText = NSAttributedString(string: text, attributes: [
            .font: UIFont.systemFont(ofSize: 12)
        ])
        
        // Set up the PDF page frame
        let pageSize = CGSize(width: 612, height: 792) // Standard A4 size
        let pdfFrame = CGRect(origin: .zero, size: pageSize)
        
        // Generate the file path
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileURL = documentsDirectory?.appendingPathComponent("\(fileName).pdf")
        
        guard let outputURL = fileURL else { return nil }
        
        // Begin PDF context
        UIGraphicsBeginPDFContextToFile(outputURL.path, .zero, nil)
        
        // Start a new page
        UIGraphicsBeginPDFPageWithInfo(pdfFrame, nil)
        
        // Draw the text into the PDF context
        attributedText.draw(in: pdfFrame.insetBy(dx: 20, dy: 20))
        
        // End PDF context
        UIGraphicsEndPDFContext()
        
        return outputURL
    }
}
