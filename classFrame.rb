class Frame: CustomStringConvertible {
    var turns: [Turn] = []
    var bonus: Int = 0
    var knockedDownPins: Int = 0

    var score: Int {
        return initialScore + knockedDownPins + bonus
    }

    let initialScore: Int
    init(initialScore: Int = 0) {
        self.initialScore = initialScore
    }

   @description: String {
        return """
        |---------------------------
        | Turns: \(turns)
        |
        | Score: [ \(score) ]
        |---------------------------
        """
    }
}
