// THIS IS A DARKPACK UI FILE
import { Button, Stack, Tooltip } from 'tgui-core/components';
import { useBackend } from 'tgui/backend';

import { type PreferencesMenuData } from '../types';

export function StatsPage() {
  const { act, data } = useBackend<PreferencesMenuData>();
  if (!data) return;
  const stats = data.stats;
  const static_stats = data.static_stats;
  return (
    <Stack vertical fill>
      <Stack.Item>
        <Stack vertical className="PreferencesMenu__Stats">
          {Object.entries(stats).map(([statPath, score]) => {
            const meta = static_stats?.[statPath];
            const max = meta?.max_score ?? 5; // default max 5
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
                    <Stack fill g={1}>
                      <Stack.Item>
                        <Button
                          disabled={score <= 0}
                          onClick={() =>
                            act('decrease_stat', { stat: statPath })
                          }
                        >
                          −
                        </Button>
                      </Stack.Item>

                      <Stack.Item>{dots}</Stack.Item>

                      <Stack.Item>
                        <Button
                          disabled={score >= max}
                          onClick={() =>
                            act('increase_stat', { stat: statPath })
                          }
                        >
                          +
                        </Button>
                      </Stack.Item>
                    </Stack>
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
