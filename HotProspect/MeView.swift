//
//  MeView.swift
//  HotProspect
//
//  Created by @andreev2k on 09.08.2022.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @State private var name = "Sergey Romanovish"
    @State private var emailAddress = "andreev_sergey@bk.ru"
    @State private var qrCode = UIImage()
    
    // свойства для сохранения контекста CoreImage в котором он генерирует данное изображение
    let context = CIContext()
    // фильтр генераторa QRcoda
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                
                TextField("Email", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title2)
                
                Image(uiImage: qrCode)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .contextMenu {
                        Button {
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: qrCode)
                        } label: {
                            Label("Save to Photos", systemImage: "square.and.arrow.down")
                        }
                    }
                
            }
        } .navigationTitle("Your QR Code")
            .onAppear(perform: updateCode)
            .onChange(of: name) { _ in updateCode() }
            .onChange(of: emailAddress) { _ in updateCode() }
    }
    
    func updateCode() {
        qrCode = qrCodeGeneration(from: "\(name)\n\(emailAddress)")
    }
    
    func qrCodeGeneration(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let ouputImage = filter.outputImage {
            if let cgimg = context.createCGImage(ouputImage, from: ouputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
