/// Copyright (c) 2021 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import XCTest
@testable import SecureStore

class SecureStoreTests: XCTestCase {

  var secureStoreWithGenericPwd: SecureStore!
  var secureStoreWithInternetPwd: SecureStore!
  
  override func setUp() {
    super.setUp()
    
    let genericPwdQueryable = GenericPasswordQueryable(service: "someService")
    secureStoreWithGenericPwd = SecureStore(secureStoreQueryable: genericPwdQueryable)
    
    let internetPwdQueryable = InternetPasswordQueryable(server: "someServer",
                                                         port: 8080,
                                                         path: "somePath",
                                                         securityDomain: "someDomain",
                                                         internetProtocol: .https,
                                                         internetAuthenticationType: .httpBasic)
    secureStoreWithInternetPwd = SecureStore(secureStoreQueryable: internetPwdQueryable)
  }
  
  override func tearDown() {
    try? secureStoreWithGenericPwd.removeAllValues()
    try? secureStoreWithInternetPwd.removeAllValues()
    
    super.tearDown()
  }
  
  func testSaveGenericPassword() {
    do {
      try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
    } catch {
      XCTFail("Saving generic password failed with \(error.localizedDescription)")
    }
  }
  
  func testReadGenericPassword() {
    do {
      try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
      let password = try secureStoreWithGenericPwd.getValue(for: "genericPassword")
      XCTAssertEqual("pwd_1234", password)
    } catch {
      XCTFail("Reading generic password failed with \(error.localizedDescription)")
    }
  }
  
  func testUpdateGenericPassword() {
    do {
      try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
      try secureStoreWithGenericPwd.setValue("pwd_1235", for: "genericPassword")
      let password = try secureStoreWithGenericPwd.getValue(for: "genericPassword")
      XCTAssertEqual("pwd_1235", password)
    } catch {
      XCTFail("Updating generic password failed with \(error.localizedDescription)")
    }
  }
  
  func testRemoveGenericPassword() {
    do {
      try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
      try secureStoreWithGenericPwd.removeValue(for: "genericPassword")
      XCTAssertNil(try secureStoreWithGenericPwd.getValue(for: "genericPassword"))
    } catch {
      XCTFail("Removing generic password failed with \(error.localizedDescription)")
    }
  }
  
  func testRemoveAllGenericPasswords() {
    do {
      try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
      try secureStoreWithGenericPwd.setValue("pwd_1235", for: "genericPassword2")
      try secureStoreWithGenericPwd.removeAllValues()
      XCTAssertNil(try secureStoreWithGenericPwd.getValue(for: "genericPassword"))
      XCTAssertNil(try secureStoreWithGenericPwd.getValue(for: "genericPassword2"))
    } catch {
      XCTFail("Removing all generic passwords failed with \(error.localizedDescription)")
    }
  }
  
  func testSaveInternetPassword() {
    do {
      try secureStoreWithInternetPwd.setValue("pwd_1234", for: "internetPassword")
    } catch {
      XCTFail("Saving Internet password failed with \(error.localizedDescription)")
    }
  }
  
  func testReadInternetPassword() {
    do {
      try secureStoreWithInternetPwd.setValue("pwd_1234", for: "internetPassword")
      let password = try secureStoreWithInternetPwd.getValue(for: "internetPassword")
      XCTAssertEqual("pwd_1234", password)
    } catch {
      XCTFail("Reading Internet password failed with \(error.localizedDescription)")
    }
  }
  
  func testUpdateInternetPassword() {
    do {
      try secureStoreWithInternetPwd.setValue("pwd_1234", for: "internetPassword")
      try secureStoreWithInternetPwd.setValue("pwd_1235", for: "internetPassword")
      let password = try secureStoreWithInternetPwd.getValue(for: "internetPassword")
      XCTAssertEqual("pwd_1235", password)
    } catch {
      XCTFail("Updating Internet password failed with \(error.localizedDescription)")
    }
  }
  
  func testRemoveInternetPassword() {
    do {
      try secureStoreWithInternetPwd.setValue("pwd_1234", for: "internetPassword")
      try secureStoreWithInternetPwd.removeValue(for: "internetPassword")
      XCTAssertNil(try secureStoreWithInternetPwd.getValue(for: "internetPassword"))
    } catch {
      XCTFail("Removing Internet password failed with \(error.localizedDescription)")
    }
  }
  
  func testRemoveAllInternetPasswords() {
    do {
      try secureStoreWithInternetPwd.setValue("pwd_1234", for: "internetPassword")
      try secureStoreWithInternetPwd.setValue("pwd_1235", for: "internetPassword2")
      try secureStoreWithInternetPwd.removeAllValues()
      XCTAssertNil(try secureStoreWithInternetPwd.getValue(for: "internetPassword"))
      XCTAssertNil(try secureStoreWithInternetPwd.getValue(for: "internetPassword2"))
    } catch {
      XCTFail("Removing all internet passwords failed with \(error.localizedDescription)")
    }
  }

}
