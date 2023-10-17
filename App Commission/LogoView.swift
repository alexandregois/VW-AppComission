import SwiftUI

struct LogoView: View {
    var body: some View {
        VStack {
            Image("logo_vw_financial")
                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                                .scaleEffect(0.75)
            
            Spacer()
            
            Label("VWFS Performance", systemImage: "")
                .font(.largeTitle).foregroundColor(.black)
                           
                           
            
            Spacer()
            
            HStack {
                Image("logo_ducati")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .scaleEffect(0.85)
                
                Image("logo_audi_financial")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .scaleEffect(0.85)
            }
        }
    }
}
