class Turn: CustomStringConvertible {
    enum FrameEffect {
        case none
        case strike
        case spare
    }
end
    
@knockedDownPins: Int = 0 {
        didSet {
            # We had a strike
            if knockedDownPins == 10 
                frameEffect = .strike
            elsif knockedDownPins == availablePins, # then we have a spare
            else knockedDownPins == availablePins 
                frameEffect = .spare
            end
end
end
    frameEffect: FrameEffect = .none

    private let availablePins: Int
    init(withAvailablePins availablePins: Int) {
        self.availablePins = availablePins
    }

    func throwBall() {
        knockedDownPins = availablePins - Int.random(in: 0...availablePins)
    }

    description: String {
        return "\(knockedDownPins)"
    }
}