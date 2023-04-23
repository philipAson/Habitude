//
//  CreateTaskView.swift
//  Habitude
//
//  Created by Philip Andersson on 2023-04-23.
//

import SwiftUI

struct CreateTaskView: View {
    
    @State var taskName : String = ""
    @State var taskIsReturning : Bool = true
    
    var body: some View {
        VStack{
            TextField("Name", text: $taskName)
                .multilineTextAlignment(.center)
            Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Label@*/Text("Label")/*@END_MENU_TOKEN@*/
            }
        }
        
    }
}

struct CreateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTaskView()
    }
}
