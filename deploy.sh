server=root@107.170.33.76

cd ..

# remove the old zip file if present, locally and on server
rm -f whats-up-with-angular-universal.zip
ssh ${server} "rm -f whats-up-with-angular-universal.zip"

# zip the required directories
zip -r whats-up-with-angular-universal.zip whats-up-with-angular-universal -x \
whats-up-with-angular-universal/node_modules/**\* \
whats-up-with-angular-universal/dist/**\* >/dev/null

echo ""
echo "---------------------------------"
echo "Upload Zip"
echo "---------------------------------"

scp whats-up-with-angular-universal.zip "${server}:~"

ssh ${server} "rm -rf whats-up-with-angular-universal"
ssh ${server} "unzip whats-up-with-angular-universal.zip"
ssh ${server} "cd whats-up-with-angular-universal && npm install && npm run stopforever && npm run forever"

echo ""
echo "---------------------------------"
echo "Cleanup"
echo "---------------------------------"
rm whats-up-with-angular-universal.zip
