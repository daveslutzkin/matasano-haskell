module Spec where

import Test.Hspec
import Cipher

main :: IO ()
main = hspec $ do
    describe "Cipher.base16StringXor" $ do
        it "produces the sample output" $
            base16StringXor
                "1c0111001f010100061a024b53535009181c" "686974207468652062756c6c277320657965"
                `shouldBe`
                "746865206b696420646f6e277420706c6179"
