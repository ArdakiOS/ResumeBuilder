import SwiftUI
import PDFKit

struct MarkdownToPDFView: View {
    let markdownText = "```markdown\n**John Doe**  \nBudapest, Hungary  \n+1234567890  \njohn.doe@example.com  \n[LinkedIn](https://www.linkedin.com/in/johndoe)  \n\n---\n\n### Professional Summary\nA highly motivated software engineer with 5+ years of experience in building scalable web applications.\n\n---\n\n### Skills\n\n**Technical Skills**  \n- Java  \n- Spring  \n- MySQL  \n- Docker  \n\n**Soft Skills**  \n- Teamwork  \n- Problem-solving  \n- Time management  \n\n**Languages**  \n- English  \n- Hungarian  \n\n---\n\n### Work Experience\n\n**Software Engineer**  \n*Tech Corp*  \nNew York, USA  \n2018 - 2022  \n- Developed and maintained web applications.  \n- Collaborated with cross-functional teams.  \n\n---\n\n**Junior Developer**  \n*Startup Inc*  \nSan Francisco, USA  \n2016 - 2018  \n- Assisted in mobile application development.  \n- Wrote unit tests.  \n\n---\n\n### Education\n\n**MSc in Computer Science**  \n*University of Budapest*  \nBudapest, Hungary  \n2014 - 2016  \nGPA: 3.8  \n\n---\n\n**BSc in Information Technology**  \n*Budapest Technical University*  \nBudapest, Hungary  \n2010 - 2014  \nGPA: 3.6  \n\n---\n\n**References available upon request.**\n```"
    
    @State private var pdfURL: URL?
    
    var body: some View {
        VStack {
            if let pdfURL {
                PDFKitView(pdfURL: pdfURL)
                    
                    .frame(width: 290, height: 427)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
            } else {
                Text("Generating PDF...")
                    .onAppear {
                        pdfURL = generatePDF(from: markdownText)
                    }
            }
        }
    }
    
    func generatePDF(from markdown: String) -> URL? {
        let pdfURL = FileManager.default.temporaryDirectory.appendingPathComponent("resume.pdf")
        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 612, height: 792)) // A4 size
        
        do {
            try renderer.writePDF(to: pdfURL, withActions: { context in
                context.beginPage()
                if let attributedString = try? AttributedString(markdown: markdown) {
                    let nsAttributedString = NSAttributedString(attributedString)
                    nsAttributedString.draw(in: CGRect(x: 20, y: 20, width: 572, height: 752))
                }
            })
            return pdfURL
        } catch {
            print("Error generating PDF: \(error)")
            return nil
        }
    }
}

struct PDFKitView: UIViewRepresentable {
    let pdfURL: URL
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: pdfURL)
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = PDFDocument(url: pdfURL)
    }
}


#Preview {
    MarkdownToPDFView()
}
