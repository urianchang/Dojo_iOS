//
//  GameSprite.swift
//  MonSwifto
//
//  Created by Carolyn Yen on 3/11/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import Foundation
import SpriteKit
protocol GameSprite {
    var textureAtlas:SKTextureAtlas { get set }
    var initialSize: CGSize { get set }
    func onTap()
}
