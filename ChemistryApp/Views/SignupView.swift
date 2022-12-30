//
//  SignupViewTest.swift
//  ChemistryApp
//
//  Created by yasine romdhane on 26/12/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//

import SwiftUI
import Combine


struct SignupView: View {
    @ObservedObject var auth : AuthViewModel
    @State var inputIndex : Int = 0
    @State var isEmailValid : Bool = true
    @State var isPasswordValid : Bool = true
    @State var isPasswordConfirmValid : Bool = true
    
    @State var textFieldInputs : [String] = ["","","","","","Student"]
    @State var textFieldValidators : [Int] = [0,0,0,0,0,0]

    
    var body: some View {
        GeometryReader { geometry in
            VStack (alignment: .center, spacing: 10) {
                
                HStack {
                    Spacer()
                }
                
                VStack (alignment: .leading) {
                    Text("Create an Account")
                        .font(.title)
                        .font(.system(size: 14, weight: .bold, design: Font.Design.default))
                        .padding(.bottom, 20)
                }
                
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        if inputIndex >= 1  {
                            SetNameView(name: $textFieldInputs[1])
                                .modifier(Shake(animatableData: CGFloat(textFieldValidators[1])))
                        }
                        
                        if inputIndex >= 0  {
                            SetEmailView(email: $textFieldInputs[0], isEmailValid: $isEmailValid)
                                .modifier(Shake(animatableData: CGFloat(textFieldValidators[0])))
                        }
                        
                        if inputIndex >= 2  {
                            SetPhoneView(phoneNumber: $textFieldInputs[2])
                                .modifier(Shake(animatableData: CGFloat(textFieldValidators[2])))
                        }
                        
                        if inputIndex >= 3  {
                            SetPasswordView(password: $textFieldInputs[3])
                                .modifier(Shake(animatableData: CGFloat(textFieldValidators[3])))
                        }
                        
                        if inputIndex >= 4 {
                            SetConfirmPasswordView(confirmPassword: $textFieldInputs[4])
                                .modifier(Shake(animatableData: CGFloat(textFieldValidators[4])))
                        }
                        
                        if inputIndex >= 5  {
                            SetRoleOptionView(role: $textFieldInputs[5])
                        }
                    }
                }
                
                Button(action: {
                    withAnimation {
                        getNextStep()
                    }
                    
                }) {
                    HStack {
                        Text("Create Account")
                            .transition(.slide)
                    }
                    .padding()
                    .frame(width: geometry.size.width - 40, height: 40 )
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(5)
                    
                }.padding(.bottom, 40)
                
                
            }.padding()
        }
    }
    
    func getNextStep() {
        if(textFieldInputs[inputIndex].isEmpty){
            textFieldValidators[inputIndex] += 1
        }else{
            switch inputIndex {
            case 0:
                if self.textFieldValidatorEmail(textFieldInputs[0]) {
                    self.isEmailValid = true
                    auth.email = textFieldInputs[0]
                    inputIndex += 1
                }else{
                    self.isEmailValid = false
                    textFieldInputs[0] = ""
                }
                break;
            case 1 :
                auth.name = textFieldInputs[1]
                inputIndex += 1
                break;
            case 2:
                auth.phone = textFieldInputs[2]
                inputIndex += 1
                break;
            case 3:
                auth.password = textFieldInputs[3]
                inputIndex += 1
                break;
            case 4:
                if(textFieldInputs[4] == textFieldInputs[3]) {
                    auth.passwordConfirm = textFieldInputs[4]
                    inputIndex += 1
                }else{
                    self.isPasswordConfirmValid = false
                    textFieldValidators[4] += 1
                }
                break;
            default:
                auth.role = textFieldInputs[5]
                auth.register()
                break;
            }}}
    
    
    func textFieldValidatorEmail(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
    
    func textFieldValidatorPassword(_ string: String) -> Bool {
        if string.count > 30 || string.count < 8 {
            return false
        }else{
            return true
        }
    }
    
    func textFieldValidatorPasswordConfirm(_ string: String, initialPassword : String) -> Bool {
        if string == initialPassword {
            return true
        }else{
            return false
        }
    }
    
}

struct SetEmailView: View {
    @Binding var email : String
    @Binding var isEmailValid : Bool
    
    var body: some View {
        VStack (alignment: .leading){
            
            Text("Set your email address")
                .font(.headline)
                .padding(.leading)
            if(!isEmailValid) {
                Text("Email format not valid")
                    .foregroundColor(Color.red)
                    .font(.system(size: 12, weight: .bold))
                    .padding(.leading)
                    .transition(.slide)
            }
            
            
            TextField("Email", text: $email)
                .padding(.leading)
                .frame( height: 50)
                .accentColor(.red)
                .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                .cornerRadius(5)
                
            
            
        }.transition(.slide)
    }
}

struct SetRoleOptionView: View {
    @Binding var role : String
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Set your email address")
                .font(.headline)
                .padding(.leading)
            
            RadioButtonGroup(items: ["Student", "Teacher"], selectedId: "Student") { selected in
                role = selected
            }.padding([.leading, .trailing])
            
        }.transition(.slide)
    }
}

struct SetPhoneView: View {
    @Binding var phoneNumber : String
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Great! What's your number?")
                .font(.headline)
                .padding(.leading)
            
            TextField("Phone number", text: $phoneNumber)
                .keyboardType(.numberPad)
                .padding(.leading)
                .frame( height: 50)
                .accentColor(.red)
                .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                .cornerRadius(5)
                .onReceive(Just(phoneNumber)) { newValue in
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    if filtered != newValue {
                        self.phoneNumber = filtered
                    }
                }
        }.transition(.slide)
    }
}

struct SetNameView: View {
    @Binding var name : String
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Sorry what's your name again?")
                .font(.headline)
                .padding(.leading)
            
            TextField("Full name", text: $name)
                .padding(.leading)
                .frame( height: 50)
                .accentColor(.red)
                .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                .cornerRadius(5)
        }.transition(.slide)
    }
}

struct SetPasswordView: View {
    @Binding var password : String
    //    @Binding var isPasswordValid : Bool
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Set your password, we're not looking!")
                .font(.headline)
                .padding(.leading)
            
            //            if(!isPasswordValid) {
            //                Text("Password must be atleast 8 chars")
            //                    .foregroundColor(Color.red)
            //                    .font(.system(size: 12, weight: .bold))
            //                    .padding(.leading)
            //                    .transition(.slide)
            //            }
            
            SecureField("Password", text: $password)
                .padding(.leading)
                .frame( height: 50)
                .accentColor(.red)
                .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                .cornerRadius(5)
        }.transition(.slide)
    }
}

struct SetConfirmPasswordView: View {
    @Binding var confirmPassword : String
    
    var body: some View {
        VStack (alignment: .leading){
            Text("One more time!")
                .font(.headline)
                .padding(.leading)
            
            SecureField("Confirm Password", text: $confirmPassword)
                .padding(.leading)
                .frame( height: 50)
                .accentColor(.red)
                .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                .cornerRadius(5)
        }.transition(.slide)
    }
}

