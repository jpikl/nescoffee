import BusConnected from '../common/BusConnected'; // eslint-disable-line no-unused-vars
import Resettable from '../common/Resettable'; // eslint-disable-line no-unused-vars
import Ticking from '../common/Ticking'; // eslint-disable-line no-unused-vars

/**
 * DMA interface.
 * @interface
 * @extends {BusConnected}
 * @extends {Resettable}
 * @extends {Ticking}
 */
export default class DmaInterface {

  /**
   * Starts DMA transfer.
   * @param {number} blockNumber Number (8-bit) of 256 B data block to transfer.
   */
  startTransfer(blockNumber) { // eslint-disable-line no-unused-vars
  }

  /**
   * Returns whether DMA transfer is blocking CPU.
   * @returns {boolean} True if CPU is being blocked, false otherwise.
   */
  isBlockingCpu() {
  }

}
