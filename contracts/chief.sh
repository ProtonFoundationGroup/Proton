VSN=$1
cd chief/src
abigen --sol chief_$VSN.sol --pkg chieflib --out ../lib/chief_$VSN.go
cd ../../
