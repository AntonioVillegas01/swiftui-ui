//
//  CourseList.swift
//  SwiftUiApp
//
//  Created by Marco Antonio García Villegas on 25/05/20.
//  Copyright © 2020 Marco Antonio García Villegas. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CourseList: View {
    @ObservedObject var store = CourseStore()
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var isScrollable = false
    
    var body: some View {
        GeometryReader { bounds in
            ZStack {
                Color.black.opacity(Double(self.activeView.height / 500) )
                    .animation(.linear)
                    .edgesIgnoringSafeArea(.all)
                
                
                ScrollView {
                    VStack(spacing: 30) {
                        Text("Courses")
                            .font(.largeTitle).bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading,30)
                            .padding(.top,30)
                            .blur(radius: self.active ? 20 : 0)
                        ForEach(self.store.courses.indices, id: \.self) { index in
                            GeometryReader { geometry in
                                CourseView(
                                    show: self.$store.courses[index].show,
                                    active: self.$active,
                                    course: self.store.courses[index],
                                    index: index,
                                    activeIndex: self.$activeIndex,
                                    activeView: self.$activeView,
                                    bounds: bounds, isScrollable: self.$isScrollable
                                )
                                    .offset(y: self.store.courses[index].show ? -geometry.frame(in: .global).minY : 0)
                                    .opacity(self.activeIndex != index && self.active ? 0 : 1)
                                    .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                                    .offset(x: self.activeIndex != index && self.active ? bounds.size.width : 0)
                            }
                                //.frame(self.courses[index].show  ? screen.height :280)
                                .frame(height: self.horizontalSizeClass == .regular ? 80 : 280)
                                .frame(maxWidth: self.store.courses[index].show  ? 712 :  getCardWidth(bounds: bounds))
                                .zIndex(self.store.courses[index].show ? 1 : 0)
                        }
                    }
                    .frame(width: bounds.size.width)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                }
                .statusBar(hidden: self.active ? true : false)
                .animation(.linear)
                .disabled(self.active && !self.isScrollable ? true : false)
            }
        }
    }
}

func getCardWidth(bounds: GeometryProxy) -> CGFloat {
    if bounds.size.width > 712 {
        return 712
    }
    return bounds.size.width - 60
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}
func getCardCornerRadius(bounds: GeometryProxy) -> CGFloat {
    if bounds.size.width < 712 && bounds.safeAreaInsets.top < 44{
        return 0
    }
    
    return 30
}

struct CourseView: View {
    @Binding var show: Bool
    @Binding var active: Bool
    var course: Course
    var index: Int
    @Binding var activeIndex: Int
    @Binding var activeView: CGSize
    var bounds: GeometryProxy
    @Binding var isScrollable: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 30.0) {
                Text("Take SwuifUI app to the App Store With advanced techniques like API data, packages and CMS")
                Text("About this course")
                    .font(.title).bold()
                Text("Work Sans is a typeface family based loosely on early Grotesques, such as those by Stephenson Blake, Miller & Richard and Bauerschen Giesserei. The Regular weight and others in the middle of the family are optimised for on-screen text usage at medium-sizes (14px-48px) and can also be used in print design. The fonts closer to the extreme weights are designed more for display use both on the web and in print. Overall, features are simplified and optimised for screen resolutions; for example, diacritic marks are larger than how they would be in print. A version optimised for desktop applications is available from the Work Sans github project page.")
                Text("The Work Sans project is led by Wei Huang, a type designer from Australia. To contribute, see github.com/weiweihuanghuang/Work-Sans Updated August 2015: All styles were updated to v1.40 to change the Thin (100) style to be the same as 'HairLine' in previous versions - even thinner! This avoids the complication of a second family. The ExtraLight (200) and Light (300) styles also changed accordingly. Reflow will occur from previous versions on these weights.Updated February 2020: Family has been upgraded to a variable font family.")
            }
            .animation(nil)
            .padding(30)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280, alignment: .top)
            .offset(y: show ? screen.height - 350 : 0)
            .background(Color("background1"))
            .clipShape(RoundedRectangle(cornerRadius: show
                ? getCardCornerRadius(bounds: bounds)
                : 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                .opacity(show ? 1 : 0)
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color.white)
                        Text(course.subtitle)
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    Spacer()
                    ZStack {
                        Image(uiImage: course.logo)
                            .opacity(show ? 0 : 1)
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size:16, weight:.medium))
                                .foregroundColor(.white)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.black)
                        .clipShape(Circle())
                        .opacity(show ? 1 : 0)
                        .offset(x:2, y: -2)
                    }
                }
                Spacer()
                WebImage(url: course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
                //    .frame(width: show ? screen.width : screen.width - 60, height: show ? screen.height : 280)
                .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280 )
                .padding(show ? 30 : 20)
                .padding(.top, show ? 30 : 20 )
                .background(Color(course.color))
                .clipShape(RoundedRectangle(cornerRadius: show
                    ? getCardCornerRadius(bounds: bounds)
                    : 30, style: .continuous))
                .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)
                .gesture( show ?
                    DragGesture().onChanged{ value in
                        guard value.translation.height < 300 else {return}
                        guard value.translation.height > 0 else {return}
                        self.activeView = value.translation
                    }
                    .onEnded{ value in
                        if self.activeView.height > 50 {
                            self.show = false
                            self.active = false
                            self.activeIndex = -1
                            self.isScrollable = false
                        }
                        self.activeView = .zero
                    }
                    : nil
            )
                .onTapGesture {
                    self.show.toggle()
                    self.active.toggle()
                    if self.show {
                        self.activeIndex = self.index
                    }else{
                        self.activeIndex = -1
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        self.isScrollable = true
                    }
                    
            }
            if isScrollable{
                CourseDetail(
                    course: course,
                    show: $show,
                    active: $active,
                    activeIndex: $activeIndex,
                    isScrollabe: $isScrollable,
                    bounds: bounds
                )
                    .background(Color("background1"))
                    .clipShape(RoundedRectangle(cornerRadius: show ? getCardCornerRadius(bounds: bounds) : 30, style: .continuous))
                    .animation(nil)
                    .transition(.identity)
            }
        }
        .frame(height: show ? bounds.size.height
            + bounds.safeAreaInsets.top
            + bounds.safeAreaInsets.bottom
            : 280)
            .scaleEffect(1 - self.activeView.height / 1000)
            .rotation3DEffect(Angle(degrees: Double(self.activeView.height / 10)), axis: (x: 0.0, y: 10.0, z: 0.0))
            .hueRotation(Angle(degrees: Double(self.activeView.height )))
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .gesture( show ?
                DragGesture().onChanged{ value in
                    guard value.translation.height < 300 else {return}
                    guard value.translation.height > 50 else {return}
                    self.activeView = value.translation
                }
                .onEnded{ value in
                    if self.activeView.height > 50 {
                        self.show = false
                        self.active = false
                        self.activeIndex = -1
                        self.isScrollable = false
                    }
                    self.activeView = .zero
                }
                : nil
        )
            
            .disabled(active && !isScrollable ? true : false)
            .edgesIgnoringSafeArea(.all)
    }
}


struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var image: URL
    var logo: UIImage
    var color: UIColor
    var show: Bool
}

var courseData = [
    Course(title: "Prototypes Designs in Swift", subtitle: "18 Sections",
           image: URL(string: "https://dl.dropbox.com/s/c9o0nhnw7llb6ix/Certificate%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), show: false),
    Course(title: "Swift Advanced", subtitle: "20 Sections",
           image: URL(string: "https://dl.dropbox.com/s/rnbf172vkl18qb4/Card1%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), show: false),
    Course(title: "UI Design for developers", subtitle: "25 Sections",
           image: URL(string: "https://dl.dropbox.com/s/3hj77bgjt2s2b7r/Card2%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), show: false),
    
]
