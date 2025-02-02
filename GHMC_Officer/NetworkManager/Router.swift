//
//  Router.swift
//  GHMC_Officer
//
//  Created by IOSuser3 on 05/09/19.
//  Copyright © 2019 IOSuser3. All rights reserved.
//

import Foundation
import Foundation
import Alamofire
import UIKit

let ENV = 4

let PROD = 1
let STAG = 2
let DEMO = 3
let DEV  = 4
let LOC  = 5

var fcm_Key:String! = nil
let urlRequestTimeOutInterval = 60
let displayMessageTime = 2.0
let characterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ ")
//let userid = "cgg@ghmc"
//let password = "ghmc@cgg@2018"


let BASE_URL: String = getBaseURL()

func getBaseURL() -> String {
    
    if ENV == PROD { // Production
        return "https://www.ghmc.gov.in/GhmcMobileApp/Grievance/"
        
    } else if ENV == STAG { // Staging
        return   ""
        
    } else if ENV == DEMO { // Testing
        return ""
        
    } else if ENV == DEV { // Development
        return "http://testghmc.cgg.gov.in/GhmcMobileApp/Grievance/"
        
    } else { // Local Server
        return ""
    }
}
let CandDBASE_URL: String = getCandDBaseURL()

func getCandDBaseURL() -> String {
    
    if ENV == PROD { // Production
        return "https://www.ghmc.gov.in/GhmcMobileApp/Grievance/"
        
    } else if ENV == STAG { // Staging
        return   ""
        
    } else if ENV == DEMO { // Testing
        return ""
        
    } else if ENV == DEV { // Development
        return "http://testghmc.cgg.gov.in/CNDMAPI/CNDM/"
        
    } else { // Local Server
        return ""
    }
}


enum Router:URLRequestConvertible{
    
    // myghmcOfficer
    case mobileNumber( MOBILE_NO:String)
    case resendOtp(params:Parameters)
    case getAllCount(params:Parameters)
    case fcmKeyOfficer(params:Parameters)
    case userList(params:Parameters)
    case userDetails(params:Parameters)
    case fullGrievence(param:Parameters)
    case grivenceHistory(params:Parameters)
    case getstatusType(params:Parameters)
    case getWard(params:Parameters)
    case getClaimtStatus(params:Parameters)
    case forwordtoAnotherWard(params:Parameters)
    case updateGrivence(params:Parameters)
    case abstarctReport(params:Parameters)
    case showNotifications(params:Parameters)
    case getGrievanceTypeList(parameters: Parameters)
    case getCategoryTypeList(parameters: Parameters)
    case getViewGrievances(parameters: Parameters)
    case getGrievanceStatusCitizen(parameters: Parameters)
    case reopenserviceCall(parameters: Parameters)
    case postcommentService(parameters: Parameters)
    case postFeedback(Parameters:Parameters)
    case GrievancesCategoryList(Parameters:Parameters)
    case versionCheck(Parameters:Parameters)
    case whereIam(Parameters:Parameters)
    case insertGrievance(Parameters:Parameters)
    case getRamkeyVehicles(Parameters:Parameters)
    //C and D waste
    //AMOH
    case getAMOHRequestList(Parameters:Parameters)
    case getAMOHRequestEstimation(Parameters:Parameters)
    case getClaimTypes
    case calculateAmountbyTons(Parameters:Parameters)
    case getVehicleData
    case getAmohDashboardList(Parameters:Parameters)
    case submitAMohReq(Parameters:Parameters)
    case submitPaymentReq(Parameters:Parameters)
    case getConcessionerRejectList(Parameters:Parameters)
    case getPaymentConformedList(Parameters:Parameters)
    case concessionerReassignstatus(Parameters:Parameters)
    case raiseRequest(Parameters:Parameters)
    //Concessioner
    case getConcessionerTickets(Parameters:Parameters)
    case submitConcessionerReq(Parameters:Parameters)
    case getConcessionerDashboardList(Parameters:Parameters)


    
    case sendFile(senderName:String,senderMobileNo:String,senderDeviceIMEI:String,Qrcode:String,reciverName:String,recciverMobileNO:String)
    //revokeFile
    case revokeFile(senderName:String,senderMobileNo:String,senderDeviceIMEI:String,fileName:String)
    //acknoeledge
    case acknoeledge(name:String,mobilenumbe:String,IMEI:String,Qrcode:String)
    //mpin
    case mpinGeneration(userId:String,mPin:String)
    //forgotPassword
    case forgotPassword(userId:String)
    
    
    var method:HTTPMethod{
        
        switch self {
        case .mobileNumber,.sendFile,.revokeFile,.acknoeledge,.mpinGeneration,.forgotPassword,.fcmKeyOfficer,.getClaimTypes,.getVehicleData:
            return .get
        case .resendOtp:
            return .post
        case .getAllCount,.userList,.userDetails,.fullGrievence,.grivenceHistory,.getstatusType,.getWard,.getClaimtStatus,.forwordtoAnotherWard,.updateGrivence,.abstarctReport,.showNotifications,.getGrievanceTypeList,.getCategoryTypeList,.getViewGrievances,.getGrievanceStatusCitizen,.reopenserviceCall,.postcommentService,.postFeedback,.getRamkeyVehicles, .versionCheck,.GrievancesCategoryList,.whereIam,.insertGrievance,.getAMOHRequestList,.getAMOHRequestEstimation,.calculateAmountbyTons,.getAmohDashboardList,.getConcessionerTickets,.submitConcessionerReq,.submitAMohReq,.getConcessionerRejectList,.getPaymentConformedList,.submitPaymentReq,.concessionerReassignstatus,.getConcessionerDashboardList,.raiseRequest:
            return .post
        }
    }
    var path:String {
        switch self {
        case .mobileNumber:
            return "getMpin?"
        case .resendOtp:
            return "ResendOTP"
        case .getAllCount:
              return "GetAllCount"
        case .fcmKeyOfficer:
            return "updateFCM_KEYOfficer?"
        case .userList:
            return "UserList"
        case .userDetails:
            return "validategrievance"
        case .fullGrievence:
            return "viewTypeGrievances"
        case .grivenceHistory:
            return "viewGrievanceHistory1"
        case .getstatusType:
            return "getStatusType"
        case .getWard:
            return "getWard"
        case .getClaimtStatus:
            return "getClaimantStatusType"
        case .forwordtoAnotherWard:
            return "updateWard"
        case .updateGrivence:
            return "updateGrievance"
        case .abstarctReport:
            return "empAbstractProfile"
        case .showNotifications:
            return "ShowNotifications"
        case .sendFile:
            return "physicalNotefile/sending"
        case .revokeFile:
            return "physicalNotefile/revert"
        case .acknoeledge:
            return "physicalFileAcknowledge"
        case .mpinGeneration:
            return "updatingMpin/webApp"
        case .forgotPassword:
            return "forgotMpin/webApp"
        case .getGrievanceTypeList:
            return "CategoryList"
        case .getCategoryTypeList:
            return "getSubCategoty"
        case .getViewGrievances:
            return "viewGrievances"
        case .getGrievanceStatusCitizen:
            return   "getGrievanceStatusCitizen"
        case .reopenserviceCall:
            return "ReopenService"
        case .postcommentService:
            return "updateGrievance"
        case .postFeedback:
            return "postFeedback"
        case .GrievancesCategoryList:
            return "Grievance/CategoryList"
        case .whereIam:
            return "WhereAmI"
        case .insertGrievance:
            return "insertGrievance"
        case .getRamkeyVehicles:
            return "getRamkyVehicles"
        case .versionCheck:
            return "versionCheck"
            // C and D  waste
        case .getAMOHRequestList:
            return "GET_AMOH_REQUEST_LIST"
        case .getAMOHRequestEstimation:
            return "GET_AMOH_REQUEST_ESTIMATION_BY_ID"
        case .getClaimTypes:
            return "GetClaimTypes"
        case .calculateAmountbyTons:
            return "CalculateAmountByTons"
        case .getVehicleData:
            return "GetVehicleTypes"
        case .getAmohDashboardList:
            return "GET_AMOH_DASHBOARD_LIST"
        case .getConcessionerTickets:
            return "GET_CONCESSIONER_TICKET_LIST"
        case .submitConcessionerReq:
            return "CONCESSIONER_REQUEST_SUBMIT"
        case .submitAMohReq:
            return "AMOH_REQUEST_ESTIMATION_SUBMIT"
        case .getConcessionerRejectList:
            return "CONCESSIONER_REJECTED_TICKETS_LIST"
        case .getPaymentConformedList:
            return "GET_AMOH_AMOUNT_PAID_LIST"
        case .submitPaymentReq:
            return ""
        case .raiseRequest:
            return ""
        case .concessionerReassignstatus:
            return "AMOH_REASSIGN_CONCESSIONER_REJECTED_TICKETS"
        case .getConcessionerDashboardList:
            return "GET_CONCESSIONER_DASHBOARD_LIST"
        }
    }
    func asURLRequest() throws -> URLRequest {
        let url = try BASE_URL.asURL()
        let canddurl = try CandDBASE_URL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = TimeInterval(urlRequestTimeOutInterval)
        
        var urlRequestIs = URLRequest(url: canddurl.appendingPathComponent(path))
        urlRequestIs.httpMethod = method.rawValue
        urlRequestIs.timeoutInterval = TimeInterval(urlRequestTimeOutInterval)
        
        switch self {
        case .mobileNumber(let mobilenumber):
            let pathString = path + "MOBILE_NO=\(mobilenumber)"
            urlRequest = URLRequest(url: url.appendingPathComponent(pathString))
            urlRequest.httpMethod = method.rawValue
            urlRequest = try JSONEncoding.default.encode(urlRequest)
        case .resendOtp(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            urlRequest = try JSONEncoding.default.encode(urlRequest)
            print(urlRequest)
        case .getAllCount(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            urlRequest = try JSONEncoding.default.encode(urlRequest)
            print(urlRequest)
        case .getWard(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            urlRequest = try JSONEncoding.default.encode(urlRequest)
        case .userList(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            urlRequest = try JSONEncoding.default.encode(urlRequest)
            print(urlRequest)
        case .getstatusType(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            urlRequest = try JSONEncoding.default.encode(urlRequest)
        case .grivenceHistory(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            urlRequest = try JSONEncoding.default.encode(urlRequest)
            print(urlRequest)
        case .fullGrievence(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            urlRequest = try JSONEncoding.default.encode(urlRequest)
        case .userDetails(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            urlRequest = try JSONEncoding.default.encode(urlRequest)
          //  print(urlRequest)
        case .getClaimtStatus(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            urlRequest = try JSONEncoding.default.encode(urlRequest)
        case .forwordtoAnotherWard(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            urlRequest = try JSONEncoding.default.encode(urlRequest)
        case .updateGrivence(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            urlRequest = try JSONEncoding.default.encode(urlRequest)
        case .abstarctReport(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            urlRequest = try JSONEncoding.default.encode(urlRequest)
        case .showNotifications(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            urlRequest = try JSONEncoding.default.encode(urlRequest)
        case .fcmKeyOfficer(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            urlRequest = try JSONEncoding.default.encode(urlRequest)
        //print(urlRequest)
        case .getGrievanceTypeList(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            urlRequest = try JSONEncoding.default.encode(urlRequest)
        case .getCategoryTypeList(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .whereIam(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            urlRequest = try JSONEncoding.default.encode(urlRequest)
        case .insertGrievance(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            urlRequest = try JSONEncoding.default.encode(urlRequest)
        case .getViewGrievances(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .getGrievanceStatusCitizen(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .reopenserviceCall(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .postcommentService(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .postFeedback(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .GrievancesCategoryList(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .acknoeledge(let name, let mobilenumber, let deviceIMEI, let Qrcode):
            urlRequest.setValue(mobilenumber, forHTTPHeaderField: "mobileNumber")
            urlRequest.setValue(name, forHTTPHeaderField: "userName")
            urlRequest.setValue(deviceIMEI, forHTTPHeaderField: "deviceIMEI")
            urlRequest.setValue(Qrcode, forHTTPHeaderField:"qrCode")
            urlRequest = try JSONEncoding.default.encode(urlRequest)
        case .revokeFile(let name, let mobilenumber, let deviceIMEI, let fileName):
            urlRequest.setValue(mobilenumber, forHTTPHeaderField: "mobileNumber")
            urlRequest.setValue(name, forHTTPHeaderField: "userName")
            urlRequest.setValue(deviceIMEI, forHTTPHeaderField: "deviceIMEI")
            urlRequest.setValue(fileName, forHTTPHeaderField:"physicalFileNumber")
            urlRequest = try JSONEncoding.default.encode(urlRequest)
        case .mpinGeneration(let userId, let mPin):
            urlRequest.setValue(userId, forHTTPHeaderField: "userName")
            urlRequest.setValue(mPin, forHTTPHeaderField: "mPin")
            urlRequest = try JSONEncoding.default.encode(urlRequest)
        case .forgotPassword(let userId):
            urlRequest.setValue(userId, forHTTPHeaderField: "userName")
            urlRequest = try JSONEncoding.default.encode(urlRequest)
        case .sendFile(let senderName, let senderMobilenumberNo, let senderDeviceIMEI, let Qrcode,let reciverName,let reciverMobileNumber):
            urlRequest.setValue(senderName, forHTTPHeaderField: "senderName")
            urlRequest.setValue(senderMobilenumberNo, forHTTPHeaderField: "senderMobileNo")
            urlRequest.setValue(senderDeviceIMEI, forHTTPHeaderField: "senderDeviceIMEI")
            urlRequest.setValue(Qrcode, forHTTPHeaderField:"qrCode")
            urlRequest.setValue(reciverName, forHTTPHeaderField:"receiverName")
            urlRequest.setValue(reciverMobileNumber, forHTTPHeaderField:"receiverMobileNo")
            urlRequest = try JSONEncoding.default.encode(urlRequest)
        case .getRamkeyVehicles(Parameters: let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .versionCheck(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        //AMOH
        case .getAMOHRequestList(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequestIs, with: parameters)
        case .getAMOHRequestEstimation(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequestIs, with: parameters)
        case .getClaimTypes:
            urlRequest = try JSONEncoding.default.encode(urlRequestIs)
        case .calculateAmountbyTons(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequestIs, with: parameters)
        case .getVehicleData:
            urlRequest = try JSONEncoding.default.encode(urlRequestIs)
        case .getAmohDashboardList(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequestIs,with: parameters)
            print(urlRequest)
        case .getConcessionerTickets(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequestIs,with: parameters)
            print(urlRequest)
        case .submitConcessionerReq(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequestIs,with: parameters)
            print(urlRequest)
        case .submitAMohReq(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequestIs,with: parameters)
            print(urlRequest)
        case .getConcessionerRejectList(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequestIs,with: parameters)
            print(urlRequest)
        case .getPaymentConformedList(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequestIs,with: parameters)
            print(urlRequest)
        case .submitPaymentReq(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequestIs,with: parameters)
            print(urlRequest)
        case .concessionerReassignstatus(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequestIs,with: parameters)
            print(urlRequest)
        case .getConcessionerDashboardList(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequestIs,with: parameters)
            print(urlRequest)
        case .raiseRequest(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequestIs,with: parameters)
            print(urlRequest)
            }
       
        
        return urlRequest
    }
    
}


