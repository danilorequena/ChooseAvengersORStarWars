//
//  ContentView.swift
//  chooseAvengersORStarWars
//
//  Created by Danilo Requena on 7/14/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Home: View {
    
    @State var profiles = [
        
        Profile(id: 0, name: "Han Solo", image: "p0", description: "Mercenary", offset: 0),
        Profile(id: 1, name: "Black Widow", image: "p1", description: "Spy", offset: 0),
        Profile(id: 2, name: "Darth Sidious", image: "p2", description: "Emperor", offset: 0),
        Profile(id: 3, name: "C3PO", image: "p3", description: "Android", offset: 0),
        Profile(id: 4, name: "Luke Skywalker", image: "p4", description: "Jedi", offset: 0),
        Profile(id: 5, name: "Yoda", image: "p5", description: "Master Jedi", offset: 0),
        Profile(id: 6, name: "Obi-Wan Kenobi", image: "p6", description: "Jedi", offset: 0),
        Profile(id: 7, name: "Darth Vader", image: "p7", description: "Sith", offset: 0),
        Profile(id: 8, name: "Thanos", image: "p8", description: "Crazy Titan", offset: 0),
        Profile(id: 9, name: "Lea", image: "p9", description: "Princess Jedi", offset: 0),
        Profile(id: 10, name: "Old Luke", image: "p10", description: "Master Jedi", offset: 0),
        Profile(id: 11, name: "Tony Stark", image: "p11", description: "Iron-Man", offset: 0),
        Profile(id: 12, name: "Peter Park", image: "p12", description: "Spider-man", offset: 0),
        Profile(id: 13, name: "Wanda Maximoff", image: "p13", description: "Scarlat Witch", offset: 0),
        Profile(id: 14, name: "Steve Rogers", image: "p14", description: "Captain America", offset: 0),
        Profile(id: 15, name: "Thor Odinson", image: "p15", description: "Thunder God", offset: 0),
        Profile(id: 16, name: "Nick Fury", image: "p16", description: "S.H.I.E.L.D", offset: 0),
        Profile(id: 17, name: "Thanos", image: "p17", description: "Crazy Titan", offset: 0),
        Profile(id: 18, name: "Peter Quill", image: "p18", description: "Star Lord", offset: 0),
        Profile(id: 19, name: "Rocket Raccoon", image: "p19", description: "Galaxy guardiam", offset: 0)
    ]

    
    var body: some View{
        VStack{
            HStack(spacing: 15) {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Image("menu")
                        .renderingMode(.template)
                }
                Text("Choose the best")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer(minLength: 0)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Image("noti")
                        .renderingMode(.template)
                }
            }
            .foregroundColor(.black)
            .padding()
            
            GeometryReader{ g in
                
                ZStack {
                    ForEach(profiles.reversed()){ profile in
                        ProfileView(profile: profile, frame: g.frame(in: .global))
                    }
                }
                
            }
            .padding([.horizontal, .bottom])
            
            Spacer(minLength: 0)
        }
        .background(Color.black.opacity(0.06).edgesIgnoringSafeArea(.all))
    }
        }

struct ProfileView: View {
    @State var profile: Profile
    var frame: CGRect
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            Image(profile.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: frame.width, height: frame.height)
                
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                (profile.offset > 0 ? Color.green : Color("Color"))
                    .opacity(profile.offset != 0 ? 0.7 : 0)
                
                HStack{
                    if profile.offset < 0 {
                        Spacer(minLength: 0)
                    }
                    
                    Text(profile.offset == 0 ? "" : (profile.offset > 0 ? "Nice" : "Rejected"))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 25)
                        .padding(.horizontal)
                    
                    
                    if profile.offset > 0 {
                        Spacer(minLength: 0)
                    }
                }
            }
            
            LinearGradient(gradient: .init(colors: [Color.black.opacity(0), Color.black.opacity(0.4)]), startPoint: .center, endPoint: .bottom)
            
            VStack(spacing: 15) {
               
                HStack{
                    VStack(alignment: .leading, spacing: 12) {
                        Text(profile.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(profile.description)
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.white)
                    
                    Spacer(minLength: 0)
                }
                
                HStack(spacing: 35) {
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        withAnimation(Animation.easeIn(duration: 0.8)) {
                            profile.offset = -500
                        }
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(20)
                            .background(Color("Color"))
                            .clipShape(Circle())
                    }
                    
                    Button(action: {
                        withAnimation(Animation.easeIn(duration: 0.8)) {
                            profile.offset = 500
                        }
                    }) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(20)
                            .background(Color.green)
                            .clipShape(Circle())
                    }
                    
                    Spacer(minLength: 0)
                }
            }
            .padding()
        }
        .cornerRadius(20)
        .offset(x: profile.offset)
        .rotationEffect(.init(degrees: profile.offset == 0 ? 0 : (profile.offset > 0 ? 12 : -12)))
        
        .gesture(
            
            DragGesture()
                .onChanged({ (value) in
                    withAnimation(.default) {
                        profile.offset = value.translation.width
                    }
                })
                .onEnded({ (value) in
                    withAnimation(Animation.easeIn) {
                        if profile.offset > 150 {
                            profile.offset = 500
                        } else if profile.offset < -150 {
                            profile.offset = -500
                        } else {
                            profile.offset = 0
                        }
                    }
                })
        )
    }
}

struct Profile : Identifiable {
    
    var id : Int
    var name : String
    var image : String
    var description : String
    var offset : CGFloat
    
    }
