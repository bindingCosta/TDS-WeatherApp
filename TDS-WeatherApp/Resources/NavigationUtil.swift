//
//  NavigationUtil.swift
//  TDS-WeatherApp
//
//  Created by Marcelo Costa on 26/11/24.
//

import SwiftUI

struct NavigationUtil {
    
    /// Volta para a tela anterior usando o UINavigationController.
    static func popView() {
        // Tenta encontrar o UINavigationController e fazer o pop, senão nada acontece.
        guard let navigationController = findNavigationController() else { return }
        navigationController.popViewController(animated: true)
    }

    /// Localiza o UINavigationController no root da aplicação.
    private static func findNavigationController() -> UINavigationController? {
        // Pega o rootViewController da view principal e tenta encontrar um UINavigationController.
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = scene.windows.first?.rootViewController else {
            return nil
        }
        
        return findNavigationController(from: rootViewController)
    }

    /// Busca recursivamente por um UINavigationController entre os view controllers filhos.
    private static func findNavigationController(from viewController: UIViewController) -> UINavigationController? {
        // Retorna o UINavigationController, se encontrado.
        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }
        
        // Verifica os filhos (subview controllers) caso o controller atual não seja um UINavigationController.
        for child in viewController.children {
            if let navigationController = findNavigationController(from: child) {
                return navigationController
            }
        }
        
        return nil
    }
}
