//
//  Plane.swift
//  Planes
//
//  Created by David Ferreira on 30/06/2017.
//  Copyright © 2017 David Ferreira. All rights reserved.
//

import SceneKit
import ARKit

class Plane: SCNNode {
    
    var anchor: ARPlaneAnchor
    var planeGeometry: SCNPlane
    
    init(anchor: ARPlaneAnchor) {
        self.anchor = anchor
        planeGeometry = SCNPlane(width: CGFloat(self.anchor.extent.x), height: CGFloat(self.anchor.extent.z))
        
        super.init()
        
        let material = SCNMaterial()
        let img = UIImage(named: "tron_grid.png")
        material.diffuse.contents = img
        self.planeGeometry.materials = [material]
        
        let planeNode = SCNNode(geometry: planeGeometry)
        planeNode.position = SCNVector3Make(self.anchor.center.x, 0, self.anchor.center.z)
        
        planeNode.transform = SCNMatrix4MakeRotation(-.pi / 2.0, 1.0, 0.0, 0.0)
        
        setTextureScale()
        self.addChildNode(planeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setTextureScale() {
        let width = planeGeometry.width
        let height = planeGeometry.height
        
        let material = planeGeometry.materials.first
        material?.diffuse.contentsTransform = SCNMatrix4MakeScale(Float(width), Float(height), 1)
        
        material?.diffuse.wrapS = SCNWrapMode.repeat
        material?.diffuse.wrapT = SCNWrapMode.repeat
    }
    
    func update(anchor: ARPlaneAnchor) {
        self.planeGeometry.width = CGFloat(anchor.extent.x)
        self.planeGeometry.height = CGFloat(anchor.extent.z)
        
        
        self.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
        setTextureScale()
    }

}
