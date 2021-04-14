//
//  LogoService.swift
//  LogoViewer-IOS
//
//  Created by Mehdi Benrefad on 14/04/2021.
//  Copyright © 2021 Mehdi Benrefad. All rights reserved.
//

import Foundation


class LogoService {
    static let shared = LogoService()
    private init() {}

    //on declare la premiere partie de l'url (sans domaine)
    private let Url = "https://logo.clearbit.com/"
    
    //cette fois ci pour factoriser le code on declare la tache embalee a l'exterieur afin de l'appeler toute fois on a besoin de l'utiliser
    private var task: URLSessionDataTask?
    
    
    //la voici la fonction qui vq faire la connexion avec l'API et qui vq nous permettre de charger les logos
    func getLogo(domain: String, callback: @escaping (Bool, Data?) -> Void) {
        //on cree une nouvelle session (on sort du main queu)
        let session = URLSession(configuration: .default)

        //ici on a a detecter les erreurs pour cela au lieu d'utiliser (if--else) on utilise le guard pour eviter le pyramide de conditions
        guard let url = URL(string: Url + domain) else {
            callback(false, nil)
            return
        }

        //on arrette la tache si elle etait deja active
        task?.cancel()
        //on  cree notre propre tache
        task = session.dataTask(with: url) { (data, response, error) in
            //on revient a la main Queu
            DispatchQueue.main.async {
                //on teste si les donnees sont recues et si on n'a pas d'erreur et on verifie que la reponse s'agit de Httpurlresponse et que la requette a reussit
                guard let data = data, error == nil,
                    let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        //sinon la requette a echoue
                        callback(false, nil)
                        return
                }
                //requette reussie , on envoi les donnees a travers le callback
                callback(true, data)
            }
        }
        
        //on lance la tache
        task?.resume()
    }
}

