import SwiftUI
import SwiftData

struct AddModelView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Environment(\.modelContext) private var context
    @Query var userModels: [UserModel]
    
    var body: some View {
        VStack {
            ZStack {
                Text("Add Model")
                    .font(.custom("Montserrat-ExtraBold", size: 27))
                    .foregroundStyle(Color(hex: ImagingHexColor.black))
                
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.backward.circle")
                            .font(.system(size: 48))
                            .foregroundStyle(Color(hex: ImagingHexColor.black))
                    }
                    .padding(.leading, 24)
                    
                    Spacer()
                }
            }
            
            List {
                ForEach(userModels) { model in
                    Text(model.name)
                        .swipeActions {
                            Button("Delete", systemImage: "trash", role: .destructive) {
                                context.delete(model)
                            }
                        }
                }
            }
            
            ScrollView {
                ForEach(0..<2) { _ in
                    modelCardView(model: .pollinations)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

private struct modelCardView: View {
    let model: ImagingModel
    @State private var showInfoSheet = false
    
    @Environment(\.modelContext) private var context
    @Query var userModels: [UserModel]
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(model.name)
                    .font(.custom("Montserrat-ExtraBold", size: 24))
                    .foregroundStyle(Color(hex: ImagingHexColor.black))
                
                Text(model.company)
                    .font(.custom("Montserrat-Bold", size: 17))
                    .foregroundStyle(Color(hex: model.customHexColor.companyHexColor))
                
                Button {
                    withAnimation(.linear(duration: 3)) {
                        let newUserModel = UserModel(name: model.name, apiKey: nil)
                        context.insert(newUserModel)
                    }
                } label: {
                    Text(isModelAdded() ? "Added" : "Add")
                        .padding(.vertical, 10)
                        .padding(.horizontal, 18)
                        .font(.custom("Montserrat-ExtraBold", size: 12))
                        .foregroundStyle(Color(hex: ImagingHexColor.white))
                        .background(Color(hex: ImagingHexColor.black))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .animation(.linear, value: 10)
                }
            }
            
            Spacer()
            
            Image(model.iconResource)
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(.circle)
                .overlay(
                    Circle()
                        .strokeBorder(Color(hex: ImagingHexColor.black), lineWidth: 2)
                )
        }
        .frame(width: 327)
        .padding(.all, 24)
        .background(Color(hex: model.customHexColor.backgroundHexColor))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color(hex: ImagingHexColor.black), lineWidth: 2)
        )
        .onTapGesture {
            showInfoSheet.toggle()
        }
        .sheet(isPresented: $showInfoSheet) {
            modelDetailView(model: model, showInfoSheet: $showInfoSheet)
        }
    }
    
    private func isModelAdded() -> Bool {
        return userModels.contains(where: {
            $0.name == model.name
        })
    }
}

private struct modelDetailView: View {
    let model: ImagingModel
    @Binding var showInfoSheet: Bool
    @State var heartTapped = false
    @State var starTapped = false
    
    var body: some View {
        VStack(spacing: 8) {
            Button {
                showInfoSheet.toggle()
            } label: {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 48))
                    .foregroundStyle(Color(hex: ImagingHexColor.black))
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(hex: ImagingHexColor.white))
                    .shadow(color: Color(hex: ImagingHexColor.black), radius: 0, x: 0, y: -6)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        Image(model.iconResource)
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(.circle)
                            .overlay(
                                Circle()
                                    .strokeBorder(Color(hex: ImagingHexColor.black), lineWidth: 2)
                            )
                            .padding(.bottom, 16)
                        
                        HStack(alignment: .center) {
                            VStack(alignment: .leading) {
                                Text(model.name)
                                    .font(.custom("Montserrat-Bold", size: 36))
                                    .foregroundStyle(Color(hex: ImagingHexColor.black))
                                
                                Text(model.company)
                                    .font(.custom("Montserrat-Bold", size: 24))
                                    .foregroundStyle(Color(hex: ImagingHexColor.grey))
                            }
                            
                            Spacer()
                            
                            Button {
                                if let url = URL(string: model.wikiUrl) {
                                    UIApplication.shared.open(url)
                                }
                            } label: {
                                Text("Go Wiki")
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 16)
                                    .font(.custom("Montserrat-ExtraBold", size: 12))
                                    .foregroundStyle(Color(hex: ImagingHexColor.black))
                                    .background(Color(hex: ImagingHexColor.yellow))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .strokeBorder(Color(hex: ImagingHexColor.black), lineWidth: 2)
                                    )
                            }
                        }
                        .padding(.bottom, 30)
                        
                        HStack {
                            Button {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    heartTapped.toggle()
                                }
                            } label: {
                                Image(systemName: heartTapped ? "heart.fill" : "heart")
                                    .bold()
                                    .font(.system(size: 24))
                                    .foregroundStyle(Color(hex: heartTapped ? ImagingHexColor.red : ImagingHexColor.black))
                                
                                Text("Like")
                                    .font(.custom("Montserrat-ExtraBold", size: 17))
                                    .foregroundStyle(Color(hex: ImagingHexColor.black))
                            }
                            
                            Spacer()
                            
                            Rectangle()
                                .frame(width: 2, height: 28)
                                .foregroundStyle(Color(hex: ImagingHexColor.black))
                            
                            Spacer()
                            
                            Button {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    starTapped.toggle()
                                }
                            } label: {
                                Image(systemName: starTapped ? "star.fill" : "star")
                                    .bold()
                                    .font(.system(size: 24))
                                    .foregroundStyle(Color(hex: starTapped ? ImagingHexColor.yellow : ImagingHexColor.black))
                                
                                Text("Favorite")
                                    .font(.custom("Montserrat-ExtraBold", size: 17))
                                    .foregroundStyle(Color(hex: ImagingHexColor.black))
                            }
                        }
                        .padding(.horizontal, 46)
                        .padding(.bottom, 24)
                        
                        Text(model.description)
                            .font(.custom("Montserrat-Medium", size: 17))
                            .foregroundStyle(Color(hex: ImagingHexColor.darkGrey))
                            .padding(.bottom, 24)
                        
                        Image(model.detailImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(Color(hex: ImagingHexColor.black), lineWidth: 2)
                            )
                            .padding(.bottom, 24)
                        
                        HStack {
                            Image(systemName: "dollarsign")
                                .font(.system(size: 17))
                            
                            Text(model.isFree ? "Free of charge" : "Charing required")
                                .font(.custom("Montserrat-Medium", size: 17))
                        }
                        .foregroundStyle(Color(hex: ImagingHexColor.black))
                        .padding(.bottom, 3)
                        
                        HStack {
                            Image(systemName: "key")
                                .font(.system(size: 17))
                            
                            Text(model.needApiKey ? "API key required" : "No API key required")
                                .font(.custom("Montserrat-Medium", size: 17))
                        }
                        .foregroundStyle(Color(hex: ImagingHexColor.black))
                    }
                }
                .padding(.top, 16)
                .padding(.horizontal, 24)
            }
            
        }
        .ignoresSafeArea()
        .presentationBackground(Color.clear)
    }
}

#Preview {
    AddModelView()
}
