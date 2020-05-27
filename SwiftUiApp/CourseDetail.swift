//
//  CourseDetail.swift
//  SwiftUiApp
//
//  Created by Marco Antonio García Villegas on 26/05/20.
//  Copyright © 2020 Marco Antonio García Villegas. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI


struct CourseDetail: View {
    var course: Course
    @Binding var show: Bool
    @Binding var active: Bool
    @Binding var activeIndex: Int
    
    var body: some View {
        ScrollView {
            VStack {
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
                            VStack {
                                Image(systemName: "xmark")
                                    .font(.system(size:16, weight:.medium))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 36, height: 36)
                            .background(Color.black)
                            .clipShape(Circle())
                            .onTapGesture {
                                self.show = false
                                self.active = false
                                self.activeIndex = -1
                            }
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
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)
                VStack(alignment: .leading, spacing: 30.0) {
                    Text("Take SwuifUI app to the App Store With advanced techniques like API data, packages and CMS")
                    Text("About this course")
                        .font(.title).bold()
                    Text("Work Sans is a typeface family based loosely on early Grotesques, such as those by Stephenson Blake, Miller & Richard and Bauerschen Giesserei. The Regular weight and others in the middle of the family are optimised for on-screen text usage at medium-sizes (14px-48px) and can also be used in print design. The fonts closer to the extreme weights are designed more for display use both on the web and in print. Overall, features are simplified and optimised for screen resolutions; for example, diacritic marks are larger than how they would be in print. A version optimised for desktop applications is available from the Work Sans github project page.")
                    Text("The Work Sans project is led by Wei Huang, a type designer from Australia. To contribute, see github.com/weiweihuanghuang/Work-Sans Updated August 2015: All styles were updated to v1.40 to change the Thin (100) style to be the same as 'HairLine' in previous versions - even thinner! This avoids the complication of a second family. The ExtraLight (200) and Light (300) styles also changed accordingly. Reflow will occur from previous versions on these weights.Updated February 2020: Family has been upgraded to a variable font family.")
                }
                .padding(30)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CourseDetail_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetail(course: courseData[0], show: .constant(true), active: .constant(true), activeIndex: .constant(-1))
    }
}
