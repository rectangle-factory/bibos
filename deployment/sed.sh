OUTPUT="No files changed, compilation skipped Deployer: 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266 Deployed to: 0x0165878a594ca255338adfa4d48449f69242eb8f Transaction hash: 0xb0d70de0ac40fd62bf6114abbd17421453c20cf3ca73045189de48aa754f01fb"
FRONT=${OUTPUT##*Deployed to: }
echo ${FRONT%% *}