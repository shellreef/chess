#!/bin/sh
for i in http://cdn-images.chesscomfiles.com/js/chess/images/chess/pieces/classic/45/{b,w}{p,b,n,r,q,k}.png; do curl -O $i; done
