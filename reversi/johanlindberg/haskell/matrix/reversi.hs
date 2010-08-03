-- Reversi kata for langgeeks

findMoves :: Char -> [String] -> Int -> [(Int,Int)]
findMoves player [] n = []
findMoves player (row:board) n = zip moves (repeat n) ++ findMoves player board (n+1)
                                 where moves = findMovesInRow player row 0 ++
                                               reverseIndex (findMovesInRow player (reverse row) 0)

cols :: [String] -> [String]
cols board = [[head (snd (splitAt n row)) | row <- board] | n <- [0..((length (head board))- 1)]]

test_cols ::  Bool
test_cols = cols ["ABC","DEF","GHI"] == ["ADG","BEH","CFI"] &&
            cols ["ABCD","EFGH","IJKL","MNOP"] == ["AEIM","BFJN","CGKO","DHLP"]

reverseIndex :: [Int] -> [Int]
reverseIndex [] = []
reverseIndex moves = map (\x -> 7 - x) moves

findMovesInRow :: Char -> String -> Int -> [Int]
findMovesInRow player [] pos = []
findMovesInRow player (x:xs) pos | x == '.'
                                   && findChain player xs 0 = [pos] ++ findMovesInRow player xs (pos+1)
                                 | otherwise                = findMovesInRow player xs (pos+1)

findChain :: Char -> String -> Int -> Bool
findChain player [] pos     = False
findChain player (x:xs) pos | x == player = pos /= 0
                            | x /= '.'    = findChain player xs (pos+1)
                            | otherwise   = False

test_findChain :: Bool
test_findChain = findChain 'B' "WWB.." 0  == True  &&
                 findChain 'B' "B.." 0    == False &&
                 findChain 'B' ".WWB.." 0 == False &&
                 findChain 'B' "..." 0    == False &&
                 findChain 'B' "W.." 0    == False

test_findMovesInRow :: Bool
test_findMovesInRow = findMovesInRow 'W' "...BW..." 0 == [2] &&
                      findMovesInRow 'W' ".BW..BW." 0 == [0,4] &&
                      findMovesInRow 'W' "...WB..." 0 == []

test_findMoves :: Bool
test_findMoves = findMoves 'W' ["...BW...","...WB..."] 0 == [(2,0),(5,1)]