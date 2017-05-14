server=root@107.170.33.76

# Switch to main folder
cd ..

# remove the old zip file if present, locally and on server
rm -f backend.zip
ssh ${server} "rm -f backend.zip"

# zip the required directories
zip -r backend.zip backend -x \
backend/node_modules/**\* \
backend/dist/**\* >/dev/null

echo ""
echo "---------------------------------"
echo "Upload Zip"
echo "---------------------------------"

scp backend.zip "${server}:~"

ssh ${server} "rm -rf backend"
ssh ${server} "unzip backend.zip"
ssh ${server} "cd backend && npm install && npm run forever"

echo ""
echo "---------------------------------"
echo "Cleanup"
echo "---------------------------------"
rm backend.zip
