import detectEthereumProvider from '@metamask/detect-provider';

if (typeof window.ethereum !== 'undefined') {
    console.log('MetaMask is installed!');
}

function load() {
    console.log(ethereum.isConnected())
}

async function loadAccount() {
    const accounts = await ethereum.request({ method: 'eth_requestAccounts' });
    const account = accounts[0];
    console.log(account)
}

async function loadContract() {
    const accounts = await ethereum.request({ method: 'eth_requestAccounts' });
    const account = accounts[0];
    console.log(account)
}

load()
loadAccount()