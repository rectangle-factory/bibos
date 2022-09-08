#!/bin/bash

# verify bibos contracts with external library addresses

forge verify-contract --chain-id 1 --compiler-version "0.8.13+commit.abaa5c0e" \
--libraries "src/libraries/Cheeks.sol:Cheeks:0x5a56533924d6694c617172592cfa7d8c63de4b4f" \
--libraries "src/libraries/Data.sol:Data:0x62897c2906035e70470d0b0a37bf31fdadf7bf67" \
--libraries "src/libraries/Eyes.sol:Eyes:0xfd61aff6cc3abc7339946f233f182dd17ef97b12" \
--libraries "src/libraries/Eyes2.sol:Eyes2:0xf7fd823e7a599e11150795e4b1c71240001188f9" \
--libraries "src/libraries/Glints.sol:Glints:0x2073341d0ac112a0bc159482d7619929d4ba3456" \
--libraries "src/libraries/Motes.sol:Motes:0x176a00344e819430136be71b66a0e7853885342f" \
--libraries "src/libraries/Mouth.sol:Mouth:0x40ccf25fc4c7e37a7aaaf58dbaf6b1f3996e478c" \
"0xf528e3381372c43f5e8a55b3e6c252e32f1a26e4"  src/Bibos.sol:Bibos $ETHERSCAN_API_KEY