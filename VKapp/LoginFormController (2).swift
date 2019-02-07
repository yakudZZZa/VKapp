//
//  LoginFormController.swift
//  Weather
//
//  Created by Евгений Иванов on 05/11/2018.
//  Copyright © 2018 Евгений Иванов. All rights reserved.
//

import UIKit

class LoginFormController: UIViewController {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet var loadingIndicator: LoadingPoints!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        loginInput.delegate = self
//        passwordInput.delegate = self
        
        // жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)

        // Do any additional setup after loading the view.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // Проверяем данные
        
//        let checkResult = checkUserData()
//
//        // Если данные неверны, покажем ошибку
//        if !checkResult {
//            showLoginError()
//        }
        
        // Вернем результат
//        sleep(3)
        
        UIView.animate(
            withDuration: 3,
            animations: {
                self.loadingIndicator.firstPoint.add(fadeInAnimation, forKey: nil)
                self.loadingIndicator.fadeInAnimation.beginTime = CACurrentMediaTime() + 0.5
               self.loadingIndicator.secondPoint.add(fadeInAnimation, forKey: nil)
                self.loadingIndicator.fadeInAnimation.beginTime = CACurrentMediaTime() + 1
                self.loadingIndicator.thridPoint.add(fadeInAnimation, forKey: nil)

        }, completion: { (complete) in
                self.loadingIndicator.isHidden = true
        })
        loadingIndicator.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            self.loadingIndicator.isHidden = true
        })
        
        return true
    }
    
    func checkUserData() -> Bool {
        let login = loginInput.text!
        let password = passwordInput.text!
//
        if login == "admin" && password == "123456" {
            return true
        } else {
            return true
        }
    }
    
    func showLoginError() {
        // Создаем контроллер
        let alert = UIAlertController(title: "Ошибка", message: "Введены не верные данные пользователя", preferredStyle: .alert)
        // Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        // Добавляем кнопку на UIAlertController
        alert.addAction(action)
        // Показываем UIAlertController
        present(alert, animated: true, completion: nil)
    }

    
    // Когда клавиатура появляется
    @objc func keyboardWasShown(_ notification: Notification) {
        
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

