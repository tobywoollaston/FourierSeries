import SpriteKit

class ComplexNumber {
    var re: CGFloat
    var im: CGFloat
    var freq: CGFloat?
    var amp: CGFloat?
    var phase: CGFloat?
    init(re: CGFloat, im: CGFloat) {
        self.re = re
        self.im = im
    }
    func add(_ c: ComplexNumber) {
        self.re += c.re
        self.im += c.im
    }
    static func mult(_ a: ComplexNumber, _ b: ComplexNumber) -> ComplexNumber {
        let re = a.re*b.re - a.im*b.im
        let im = a.re*b.im + a.im*b.re
        return ComplexNumber(re: re, im: im)
    }
}

public class FourierTransform2DPicScene: SKScene {
    
    var points = [CGPoint]()
    var fourier: [ComplexNumber]!
    
    var time: CGFloat = 0;
    let center = CGPoint(x: 350, y: 350)
    var circles = [SKShapeNode]()
    var dots = [SKShapeNode]()
    var wave = [CGPoint]()
    var circlePath: CGMutablePath!
    var circlePathShape: SKShapeNode!
    var wavePath: CGMutablePath!
    var waveShape: SKShapeNode!
    
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        backgroundColor = .black
        
        points = [CGPoint(x: 222.5, y: 276.0),
        CGPoint(x: 222.5, y: 277.0),
        CGPoint(x: 221.00003051757812, y: 284.0),
        CGPoint(x: 220.00001525878906, y: 292.0),
        CGPoint(x: 220.00001525878906, y: 305.5),
        CGPoint(x: 220.00001525878906, y: 318.5),
        CGPoint(x: 220.00001525878906, y: 341.0000305175781),
        CGPoint(x: 220.00001525878906, y: 358.5000305175781),
        CGPoint(x: 220.00001525878906, y: 371.5000305175781),
        CGPoint(x: 220.00001525878906, y: 385.0000305175781),
        CGPoint(x: 220.00001525878906, y: 398.0000305175781),
        CGPoint(x: 220.00001525878906, y: 403.0000305175781),
        CGPoint(x: 220.00001525878906, y: 408.5000305175781),
        CGPoint(x: 220.00001525878906, y: 419.5000305175781),
        CGPoint(x: 220.00001525878906, y: 429.5000305175781),
        CGPoint(x: 219.00001525878906, y: 436.0000305175781),
        CGPoint(x: 217.50001525878906, y: 443.5000305175781),
        CGPoint(x: 217.00003051757812, y: 448.5000305175781),
        CGPoint(x: 216.00001525878906, y: 454.0000305175781),
        CGPoint(x: 213.50001525878906, y: 460.5000305175781),
        CGPoint(x: 213.50001525878906, y: 465.0000305175781),
        CGPoint(x: 212.50001525878906, y: 471.0000305175781),
        CGPoint(x: 211.50001525878906, y: 475.0000305175781),
        CGPoint(x: 210.50003051757812, y: 484.0000305175781),
        CGPoint(x: 210.50003051757812, y: 490.50006103515625),
        CGPoint(x: 210.50003051757812, y: 500.5000305175781),
        CGPoint(x: 210.50003051757812, y: 503.50006103515625),
        CGPoint(x: 210.50003051757812, y: 505.5000305175781),
        CGPoint(x: 210.50003051757812, y: 509.00006103515625),
        CGPoint(x: 210.50003051757812, y: 513.0),
        CGPoint(x: 210.50003051757812, y: 517.0),
        CGPoint(x: 211.50001525878906, y: 522.5),
        CGPoint(x: 212.50001525878906, y: 529.5000610351562),
        CGPoint(x: 213.50001525878906, y: 535.0000610351562),
        CGPoint(x: 215.00001525878906, y: 539.0000610351562),
        CGPoint(x: 215.50001525878906, y: 546.5000610351562),
        CGPoint(x: 217.00003051757812, y: 552.0000610351562),
        CGPoint(x: 217.50001525878906, y: 555.0000610351562),
        CGPoint(x: 218.00001525878906, y: 557.5000610351562),
        CGPoint(x: 218.50003051757812, y: 559.5000610351562),
        CGPoint(x: 219.50003051757812, y: 561.5000610351562),
        CGPoint(x: 220.50001525878906, y: 564.0000610351562),
        CGPoint(x: 224.00001525878906, y: 568.0000610351562),
        CGPoint(x: 229.50001525878906, y: 573.0000610351562),
        CGPoint(x: 234.50001525878906, y: 575.5000610351562),
        CGPoint(x: 240.00001525878906, y: 577.0000610351562),
        CGPoint(x: 247.50003051757812, y: 579.5000610351562),
        CGPoint(x: 252.50003051757812, y: 580.0),
        CGPoint(x: 258.0000305175781, y: 580.0),
        CGPoint(x: 271.0000305175781, y: 580.0),
        CGPoint(x: 287.0000305175781, y: 577.5),
        CGPoint(x: 309.0000305175781, y: 573.0000610351562),
        CGPoint(x: 323.5000305175781, y: 569.5),
        CGPoint(x: 335.0000305175781, y: 564.0000610351562),
        CGPoint(x: 337.0000305175781, y: 562.5000610351562),
        CGPoint(x: 340.0000305175781, y: 558.5000610351562),
        CGPoint(x: 341.5000305175781, y: 555.5000610351562),
        CGPoint(x: 345.5000305175781, y: 545.5000610351562),
        CGPoint(x: 348.0000305175781, y: 539.0000610351562),
        CGPoint(x: 350.5000305175781, y: 532.5000610351562),
        CGPoint(x: 352.0000305175781, y: 525.0),
        CGPoint(x: 353.0000305175781, y: 520.0),
        CGPoint(x: 353.0000305175781, y: 514.5),
        CGPoint(x: 351.0000305175781, y: 506.5000305175781),
        CGPoint(x: 348.5000305175781, y: 501.5000305175781),
        CGPoint(x: 345.0000305175781, y: 493.5000305175781),
        CGPoint(x: 344.5000305175781, y: 492.0000305175781),
        CGPoint(x: 342.0000305175781, y: 490.00006103515625),
        CGPoint(x: 337.0000305175781, y: 485.5000305175781),
        CGPoint(x: 332.5000305175781, y: 480.5000305175781),
        CGPoint(x: 325.5, y: 475.5000305175781),
        CGPoint(x: 322.0000305175781, y: 471.5000305175781),
        CGPoint(x: 319.5000305175781, y: 469.5000305175781),
        CGPoint(x: 318.0000305175781, y: 468.5000305175781),
        CGPoint(x: 315.5000305175781, y: 465.5000305175781),
        CGPoint(x: 313.0000305175781, y: 463.0000305175781),
        CGPoint(x: 309.5000305175781, y: 459.5000305175781),
        CGPoint(x: 308.0000305175781, y: 458.0000305175781),
        CGPoint(x: 306.0000305175781, y: 456.5000305175781),
        CGPoint(x: 303.5000305175781, y: 453.50006103515625),
        CGPoint(x: 300.5, y: 450.5000305175781),
        CGPoint(x: 300.0000305175781, y: 449.0000305175781),
        CGPoint(x: 298.5000305175781, y: 447.5000305175781),
        CGPoint(x: 297.5000305175781, y: 446.0000305175781),
        CGPoint(x: 296.0000305175781, y: 444.0000305175781),
        CGPoint(x: 295.0000305175781, y: 443.5000305175781),
        CGPoint(x: 294.5000305175781, y: 443.00006103515625),
        CGPoint(x: 292.5, y: 441.50006103515625),
        CGPoint(x: 291.0000305175781, y: 440.5000305175781),
        CGPoint(x: 288.0000305175781, y: 438.5000305175781),
        CGPoint(x: 286.5000305175781, y: 438.5000305175781),
        CGPoint(x: 284.0000305175781, y: 436.5000305175781),
        CGPoint(x: 281.5000305175781, y: 434.5000305175781),
        CGPoint(x: 277.0, y: 431.00006103515625),
        CGPoint(x: 275.0000305175781, y: 430.0000305175781),
        CGPoint(x: 274.0, y: 429.0000305175781),
        CGPoint(x: 274.5000305175781, y: 429.0000305175781),
        CGPoint(x: 279.0000305175781, y: 429.0000305175781),
        CGPoint(x: 282.0, y: 429.0000305175781),
        CGPoint(x: 287.5, y: 429.0000305175781),
        CGPoint(x: 294.5000305175781, y: 429.0000305175781),
        CGPoint(x: 302.0, y: 427.5000305175781),
        CGPoint(x: 306.5000305175781, y: 427.0000305175781),
        CGPoint(x: 312.5000305175781, y: 425.0000305175781),
        CGPoint(x: 316.5000305175781, y: 423.5000305175781),
        CGPoint(x: 320.5000305175781, y: 422.0000305175781),
        CGPoint(x: 324.0000305175781, y: 420.0000305175781),
        CGPoint(x: 325.0000305175781, y: 419.0000305175781),
        CGPoint(x: 327.0000305175781, y: 417.5000305175781),
        CGPoint(x: 331.0000305175781, y: 413.0000305175781),
        CGPoint(x: 334.5000305175781, y: 409.0000305175781),
        CGPoint(x: 337.5000305175781, y: 403.5000305175781),
        CGPoint(x: 343.5000305175781, y: 396.0000305175781),
        CGPoint(x: 347.0000305175781, y: 389.0000305175781),
        CGPoint(x: 351.0000305175781, y: 380.5000305175781),
        CGPoint(x: 354.0000305175781, y: 375.0000305175781),
        CGPoint(x: 356.5000305175781, y: 366.5000305175781),
        CGPoint(x: 357.5000305175781, y: 362.5000305175781),
        CGPoint(x: 359.5000305175781, y: 358.0),
        CGPoint(x: 360.5000305175781, y: 352.50006103515625),
        CGPoint(x: 360.5000305175781, y: 349.5000305175781),
        CGPoint(x: 360.5000305175781, y: 343.5000305175781),
        CGPoint(x: 359.5000305175781, y: 337.0),
        CGPoint(x: 358.5000305175781, y: 332.0),
        CGPoint(x: 357.5000305175781, y: 329.0),
        CGPoint(x: 357.0000305175781, y: 325.5000305175781),
        CGPoint(x: 356.5000305175781, y: 322.5000305175781),
        CGPoint(x: 353.5000305175781, y: 315.0000305175781),
        CGPoint(x: 352.5000305175781, y: 312.5000305175781),
        CGPoint(x: 352.5000305175781, y: 310.5),
        CGPoint(x: 351.0000305175781, y: 309.0000305175781),
        CGPoint(x: 349.5000305175781, y: 307.50006103515625),
        CGPoint(x: 345.0000305175781, y: 302.0000305175781),
        CGPoint(x: 336.0000305175781, y: 292.5),
        CGPoint(x: 331.5000305175781, y: 289.00006103515625),
        CGPoint(x: 325.5, y: 285.0000305175781),
        CGPoint(x: 322.5000305175781, y: 282.5000305175781),
        CGPoint(x: 320.5000305175781, y: 281.0000305175781),
        CGPoint(x: 317.0000305175781, y: 278.50006103515625),
        CGPoint(x: 313.0000305175781, y: 276.0),
        CGPoint(x: 310.0000305175781, y: 274.5000305175781),
        CGPoint(x: 307.0, y: 273.5),
        CGPoint(x: 304.0000305175781, y: 273.5),
        CGPoint(x: 299.5000305175781, y: 272.5000305175781),
        CGPoint(x: 295.5000305175781, y: 271.0),
        CGPoint(x: 289.5000305175781, y: 269.5000305175781),
        CGPoint(x: 285.5000305175781, y: 268.5),
        CGPoint(x: 283.0000305175781, y: 268.5),
        CGPoint(x: 279.5, y: 268.5),
        CGPoint(x: 277.5000305175781, y: 268.00006103515625),
        CGPoint(x: 275.5, y: 267.5000305175781),
        CGPoint(x: 272.5000305175781, y: 267.0000305175781),
        CGPoint(x: 264.0000305175781, y: 267.0000305175781),
        CGPoint(x: 257.5000305175781, y: 267.0000305175781),
        CGPoint(x: 251.50003051757812, y: 267.0000305175781),
        CGPoint(x: 250.00003051757812, y: 267.0000305175781),
        CGPoint(x: 249.50003051757812, y: 267.0000305175781),
        CGPoint(x: 247.00001525878906, y: 267.0000305175781),
        CGPoint(x: 246.50001525878906, y: 267.0000305175781),
        CGPoint(x: 243.00001525878906, y: 267.0000305175781),
        CGPoint(x: 241.50001525878906, y: 267.0000305175781),
        CGPoint(x: 241.00001525878906, y: 267.0000305175781),
        CGPoint(x: 240.00001525878906, y: 267.0000305175781),
        CGPoint(x: 239.50003051757812, y: 267.0000305175781),
        CGPoint(x: 238.50001525878906, y: 267.0000305175781),
        CGPoint(x: 238.00003051757812, y: 267.0000305175781),
        CGPoint(x: 237.00003051757812, y: 267.0000305175781),
        CGPoint(x: 234.00003051757812, y: 267.0000305175781),
        CGPoint(x: 231.50003051757812, y: 266.5),
        CGPoint(x: 231.00001525878906, y: 266.5)]
        
        fourier = dft(points)
        
        var point = center
        for i in 0...(fourier.count-1) {

            let freq = fourier[i].freq!
            let radius = fourier[i].amp!
            let phase = fourier[i].phase!

            let circle = SKShapeNode(ellipseOf: CGSize(width: radius*2, height: radius*2))
            circle.strokeColor = SKColor(white: 0.5, alpha: 0.2)
            circle.position = point
            addChild(circle)
            circles.append(circle)

            let x = radius * cos(freq * time + phase)// + (CGFloat.pi / 2))
            let y = radius * sin(freq * time + phase)// + (CGFloat.pi / 2))

            point.x += x
            point.y += y

            let dot = SKShapeNode(ellipseOf: CGSize(width: 2, height: 2))
            dot.fillColor = .clear//SKColor(white: 0.5, alpha: 0.2)
            dot.strokeColor = .clear
            dot.position = point
            addChild(dot)
            dots.append(dot)
        }
        
        circlePathShape = SKShapeNode()
        addChild(circlePathShape)

        waveShape = SKShapeNode()
        addChild(waveShape)
        
    }
    
    public override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        var point = center
        
        circlePath = CGMutablePath()
        circlePath.move(to: point)

        wavePath = CGMutablePath()
//        wavePath.move(to: point)

        for i in 0...(fourier.count-1) {

            let freq = fourier[i].freq!
            let radius = fourier[i].amp!
            let phase = fourier[i].phase!

            let x = radius * cos(freq * time + phase)// + (CGFloat.pi / 2))
            let y = radius * sin(freq * time + phase)// + (CGFloat.pi / 2))

            point.x += x
            point.y += y

            dots[i].position = point

            if i+1 != dots.count {
                circles[i+1].position = point
            }
            
            circlePath.addLine(to: point)
            
//            wavePath.addLine(to: point)
        }
        
        circlePathShape.path = circlePath
        circlePathShape.strokeColor = .red
        circlePathShape.lineWidth = 0.5
        
        wave.insert(point, at: 0)

        wavePath.move(to: point)

        for x in 0...(wave.count-1) {
            wavePath.addLine(to: wave[x])
        }
        if wave.count > 150 {
            wave.removeLast()
        }

        waveShape.path = wavePath
        waveShape.lineWidth = 2
        waveShape.strokeColor = .white

        let dt = (2 * CGFloat.pi) / CGFloat(fourier.count)
        time += dt //* 0.1
        
    }
    
    func dft(_ input: [CGPoint]) -> [ComplexNumber] {
        var x = [ComplexNumber]()
        input.forEach { x.append(ComplexNumber(re: $0.x - center.x, im: $0.y - center.y)) }
        
        var X = [ComplexNumber]()
        let N = x.count
        
        for k in 0...(N-1) {
            let sum = ComplexNumber(re: 0, im: 0)
            
            for n in 0...(N-1) {
                let phi = ((2 * CGFloat.pi) * CGFloat(k) * CGFloat(n)) / CGFloat(N)
                let c = ComplexNumber(re: cos(phi), im: -sin(phi))
                sum.add(.mult(x[n], c))
            }
            
            sum.re = sum.re / CGFloat(N)
            sum.im = sum.im / CGFloat(N)
            
            sum.freq = CGFloat(k)
            sum.amp = (sum.re * sum.re + sum.im * sum.im).squareRoot()
            sum.phase = atan2(sum.im, sum.re)
            X.append(sum)
        }
        
        return X
    }
    
}
