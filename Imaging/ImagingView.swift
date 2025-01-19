import SwiftUI

struct ImagingView: View {
    @State private var isModelSelected = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Text("Imaging")
                        .font(.custom("Montserrat-ExtraBold", size: 27))
                        .foregroundStyle(Color(hex: ImagingHexColor.black))
                    
                    HStack {
                        Spacer()
                        
                        NavigationLink {
                            AddModelView()
                        } label: {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 48))
                                .foregroundStyle(Color(hex: ImagingHexColor.black))
                        }
                        .padding(.trailing, 24)
                    }
                }
                
                Spacer()
                
                if !isModelSelected {
                    Text("Press + to add a model.")
                        .font(.custom("Montserrat-Medium", size: 17))
                        .foregroundStyle(Color(hex: ImagingHexColor.darkGrey))
                }
                
                Toggle("Is Model Selected", isOn: $isModelSelected)
                
                Spacer()
                
                NavigationLink {
                    AddModelView()
                } label: {
                        HStack {
                            Image(systemName: "apple.intelligence")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(Color(hex: ImagingHexColor.white))
                            
                            Text("Start Imaging")
                                .font(.custom("Montserrat-ExtraBold", size: 21))
                                .foregroundStyle(Color(hex: ImagingHexColor.white))
                        }
                        .frame(width: 327, height: 60)
                        .background(Color(hex: isModelSelected ? ImagingHexColor.blue : ImagingHexColor.grey))
                        .animation(.easeInOut(duration: 0.25), value: isModelSelected)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .disabled(!isModelSelected)
            }
        }
    }
}

#Preview {
    ImagingView()
}
