# Azure blob Checksum Verification

This repo provides a simple mechanism to validate local file integrity against the checksums generated and stored by Azure blob storage.

1.	Clone the code from Github and enter the repo:

```
git clone https://github.com/microsoft/azure-blob-checksum-verification
cd azure-blob-checksum-verification
```

2.	Install [azcopy](https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10#download-azcopyi)

3.	Login to azcopy, example below. 

```
azcopy login
```

Set the right permissions

 
Important, to interact with the Azure Storage Account, you will need to set the right permissions for the account, even if you are the storage account owner.

If you want to upload files, you will need to assign Storage Blob Data Contributor or Storage Blob Data Owner.


4.	Run the following command to check file integrity

```
./file-verification.sh -a account -c container-path -f files -o outfile 
```

5.	You should see a confirmation content matches

```
The checksums match.
```

Also a list of all checks and results are stored in an output file.

```
File Name       Local MD5       On Azure MD5    Status

CODE_OF_CONDUCT.md      c06b12caf3c901eb3156e3dd5b0aea56        c06b12caf3c901eb3156e3dd5b0aea56        PASS
```

## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Trademarks

This project may contain trademarks or logos for projects, products, or services. Authorized use of Microsoft 
trademarks or logos is subject to and must follow 
[Microsoft's Trademark & Brand Guidelines](https://www.microsoft.com/en-us/legal/intellectualproperty/trademarks/usage/general).
Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship.
Any use of third-party trademarks or logos are subject to those third-party's policies.
