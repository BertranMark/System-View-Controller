//
//  ViewController.swift
//  System View Controller
//
//  Created by Bertran on 15.10.2018.
//  Copyright © 2018 Bertran. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate
{

    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
    }

    @IBAction func shareB(_ sender: UIButton)
    {
        guard let  image1 = image.image else { return }
        
        let act = UIActivityViewController(activityItems: [image1], applicationActivities: nil)
        // последний арг - список сервисов, которые поддерживает приложение
        
        act.popoverPresentationController?.sourceView = sender
        // см ниже :)
        
        present(act, animated: true, completion: nil)
        // послений арг - блок, который нужно выполнить после обработки контроллера
        
        // на айпадах этот контроллер - в виде поповера (облачко). и ему можно указать родительский элемент управления, а именно сендер - в данном приложении, может использоваться для этого - см две команды выше
        
        // в свойстве АктивитиТайп - можно указать какой функционал презентовать в Активити - в документации есть описание всех значений
        
    }
    
    @IBAction func safariB(_ sender: UIButton)
    {
        if let url = URL(string: "https://apple.com")
        {
          let safarVC1 = SFSafariViewController(url: url)
            present(safarVC1, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func cameraB(_ sender: UIButton)
    {
        let pic = UIImagePickerController()
        pic.delegate = self
        
        
        
        let alertCont = UIAlertController(title: "Выберите источник изображения", message: nil, preferredStyle: .actionSheet)
        let cancelAct = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertCont.addAction(cancelAct)
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            let camAct = UIAlertAction(title: "Камера", style: .default)
            { action in
                print("Пользователь выбрал камеру")
                pic.sourceType = .camera
                self.present(pic, animated: true, completion: nil)
            }
            alertCont.addAction(camAct)
        }
        
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            let photoLibrAct = UIAlertAction(title: "Фото библиотека", style: .default)
            { (action) in
                print("Пользователь выбрал альбом")
                pic.sourceType = .photoLibrary
                self.present(pic, animated: true, completion: nil)
            }
            alertCont.addAction(photoLibrAct)
        }
     
        alertCont.popoverPresentationController?.sourceView = sender // для айпада - место появления
        present(alertCont, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let  image1 = info[ UIImagePickerController.InfoKey.originalImage ] as? UIImage
        {
            image.image = image1
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func email(_ sender: UIButton)
    {
        if MFMailComposeViewController.canSendMail(), let attachm = image.image
        {
            let mc = MFMailComposeViewController()
            mc.mailComposeDelegate = self
            mc.setSubject("Sending an image")
            mc.addAttachmentData(attachm.jpegData(compressionQuality: 1.0)!, mimeType: "image/jpeg", fileName: "Bertran file send.jpg")
            present(mc, animated: true, completion: nil)
        }
        // импортивровать MessageUI библиотеку, проверить можно ли посылать email, документацию посмотреть и найти его методы и там есть у него аналогичные тому, что делали с имейдж пикером - делегаты протокольные, которые должен сбросить мейл компоуз после того, как мы набрали или отказались от сообщения. Протокол MFMailComposeViewControllerDelegate
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        print(#function)
    }
    
}

