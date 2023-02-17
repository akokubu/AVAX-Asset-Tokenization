import { getEthereum } from "@/utils/ethereum";
import { ethers } from "ethers";
import { useCallback, useEffect, useState } from "react";
import { AssetTokenization as AssetTokenizationType } from "../types";
import AssetTokenizationArtifact from "../artifacts/AssetTokenization.json";

export const AssetTokenizationAddress =
  "0x3d0976A7fed537541681Ac2eD0af2EfEB810dc47";

type PropsUseContract = {
  currentAccount: string | undefined;
};

type ReturnUseContract = {
  assetTokenization: AssetTokenizationType | undefined;
};

export const useContract = ({
  currentAccount,
}: PropsUseContract): ReturnUseContract => {
  const [assetTokenization, setAssetTokenization] =
    useState<AssetTokenizationType>();
  const ethereum = getEthereum();

  const getContract = useCallback(
    (
      contractAddress: string,
      abi: ethers.ContractInterface,
      storeContract: (_: ethers.Contract) => void
    ) => {
      if (!ethereum) {
        console.log("Ethereum object doesn't exist!");
        return;
      }
      if (!currentAccount) {
        // ログインしていない状態でコントラクト関数を呼び出すと失敗する
        console.log("currentAccount doesn't exist!");
        return;
      }
      try {
        // @ts-ignore: ethereum as ethers.providers.ExternalProvider
        const provider = new ethers.providers.Web3Provider(ethereum);
        const signer = provider.getSigner();
        const Contract = new ethers.Contract(contractAddress, abi, signer);
        storeContract(Contract);
      } catch (error) {
        console.log(error);
      }
    },
    [ethereum, currentAccount]
  );

  useEffect(() => {
    getContract(
      AssetTokenizationAddress,
      AssetTokenizationArtifact.abi,
      (Contract: ethers.Contract) => {
        setAssetTokenization(Contract as AssetTokenizationType);
      }
    );
  }, [ethereum, currentAccount, getContract]);

  return {
    assetTokenization,
  };
};
