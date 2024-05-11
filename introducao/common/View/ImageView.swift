//
//  ImageView.swift
//  introducao
//
//  Created by mac on 20/04/2024.
//

import SwiftUI
import Combine

struct ImageView: View {
    
    @State var image: UIImage = UIImage()
    let imageLoader = ImageLoader()
    let url: String
    
    init(url: String) {
        self.url = url
    }

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .onReceive(imageLoader.didChange, perform: { data in
                self.image = UIImage(data: data) ?? UIImage()
            })
            .onAppear {
                // somente chama se não houver nenhuma imagem carregada anteriormente
                if image.cgImage == nil {
                    // faz a chamada da imagem sempre que esse componente aparecer durante a rolagem
                    imageLoader.load(url: url)
                }
            }
    }
}


class ImageLoader: ObservableObject {
    
    var didChange = PassthroughSubject<Data, Never>()
    
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
   // AGORA temos uma função (e não o init) para que possamos fazer a consulta normalmente.
    func load(url: String) {
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            
            guard let data = data else { return }
            DispatchQueue.main.async {
                print("Data", data)
                self.data = data
            }
        }
        //para excutar o bloco
        task.resume()
    }
}

struct ImageView_Previews: PreviewProvider {
  static var previews: some View {
    ImageView(url: "https://picsum.photos/200")
  }
}
