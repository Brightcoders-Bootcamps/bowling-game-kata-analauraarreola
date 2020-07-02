
class Game {
    var gameEnded = false

    var playedTurns: [Turn] = []
    var lastPlayedTurn: Turn? {
        return playedTurns.last
    }

    var frames: [Frame] = []

    var currentlyAvailablePins: Int {
        let isFirstTurnOfFrame = playedTurns.count % 2 == 0
        return isFirstTurnOfFrame ? 10 : 10 - (lastPlayedTurn?.knockedDownPins ?? 0)
    }

    func printScores() {
        for frame in frames {
            print(frame)
        }
    }

    enum GameNotification: Error {
        case ended
        case cannotPlayAnotherTurn
    }

     playTurn() throws {
        if frames.count == 10 || gameEnded {
            print("You cannot play another turn on this game.")
            throw GameNotification.cannotPlayAnotherTurn
        }

        let turn = Turn(withAvailablePins: currentlyAvailablePins)
        turn.throwBall()
        playedTurns.append(turn)

      
        frames = calculateFrames()

        if playedTurns.count == 20, lastPlayedTurn?.frameEffect != .strike {
            gameEnded = true
            throw GameNotification.ended
        }
    }

    func calculateFrames() -> [Frame] {
        var frames: [Frame] = []

        
        var referenceFrame = Frame()
        var referenceFrameUpdateCounter = 0
        var skipIndex: Int?

       
        for (idx, turn) in playedTurns.enumerated() {
            
            if let skipIndex = skipIndex, skipIndex == idx {
                continue
            }

            let frameInitialScore = frames.last?.score ?? 0

            var bonus = 0
            switch turn.frameEffect {
            case .strike:
    
                bonus = (idx+1...idx+2).map(scoreForTurn(at:)).reduce(0, +)

                
                let newFrame = Frame(initialScore: frameInitialScore)
                newFrame.turns = [turn]
                newFrame.bonus = bonus
                newFrame.knockedDownPins = scoreForTurn(at: idx)

                frames.append(newFrame)

                
                skipIndex = idx

            case .spare:
             
                if idx+1 < playedTurns.count {
                    bonus = scoreForTurn(at: idx+1)
                }

                let newFrame = Frame(initialScore: frameInitialScore)
                newFrame.bonus = bonus

                newFrame.turns = [playedTurns[idx - 1], turn]

                
                newFrame.knockedDownPins = scoreForTurn(at: idx) + scoreForTurn(at: idx - 1)
                frames.append(newFrame)

            case .none:
               
                referenceFrame.knockedDownPins += turn.knockedDownPins
                referenceFrame.turns.append(turn)
                referenceFrameUpdateCounter += 1

                
                if idx < 20 && referenceFrameUpdateCounter == 2 {
                    let newFrame = Frame(initialScore: frameInitialScore)
                    newFrame.knockedDownPins = referenceFrame.knockedDownPins
                    newFrame.turns = referenceFrame.turns

                    frames.append(newFrame)

                    referenceFrame = Frame()
                    referenceFrameUpdateCounter = 0
                }
            }
        }

        return frames
    }

    func scoreForTurn(at index: Int) -> Int {
        if index < playedTurns.count {
            return playedTurns[index].knockedDownPins
        }

        return 0
    }
}

let game = Game()

for _ in (0..<21) {
    do {
        try game.playTurn()
    } catch {
        print(error)
        break
    }
}
end 
game.printScores()