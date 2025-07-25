import type { Feature } from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const dice_output: Feature<string> = {
  name: 'Dice output',
  category: 'GAMEPLAY',
  description: 'How the results of storyteller dice rolls are output to you.',
  component: FeatureDropdownInput,
};
