// THIS IS A DARKPACK UI FILE
import { Stack, Tooltip } from 'tgui-core/components';
import { useBackend } from 'tgui/backend';

import { type PreferencesMenuData } from '../types';

export function StatsPage() {
  const { act, data } = useBackend<PreferencesMenuData>();
  if (!data) return;
  const stats = data.stats;
  const staticStats = data.staticStats;
  return (
    <Stack vertical fill>
      <Stack.Item>
        <Stack vertical className="PreferencesMenu__Stats">
          {Object.entries(stats).map(([statPath, score]) => {
            const meta = staticStats?.[statPath];
            const max = meta?.maxScore ?? 5; // default max 5
            const label = meta?.name ?? statPath.split('/').pop();
            // Render dots with empty placeholders
            const filled = '●'.repeat(score);
            const empty = '○'.repeat(max - score);
            const dots = filled + empty;
            return (
              <Stack.Item key={statPath}>
                <Stack fill>
                  <Stack.Item grow basis="50%">
                    <Tooltip content={meta?.desc}>
                      <span>{label}</span>
                    </Tooltip>
                  </Stack.Item>
                  <Stack.Item grow basis="50%" textAlign="right">
                    {dots}
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            );
          })}
        </Stack>
      </Stack.Item>
    </Stack>
  );
}
