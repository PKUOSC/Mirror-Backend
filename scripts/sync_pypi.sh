#!/bin/bash

for i ({1..5}){
    echo $i
    nohup bandersnatch mirror > log/pypi${i}.txt
}
