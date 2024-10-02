import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const EtherStakingModule = buildModule("EtherStakingModule", (m) => {

    const etherStaking = m.contract("EtherStaking", [2]);

    return { etherStaking };
});

export default EtherStakingModule;

