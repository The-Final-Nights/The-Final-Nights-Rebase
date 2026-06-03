// THIS IS A TFN UI FILE
import { useBackend } from 'tgui/backend';
import { Button, Section, Table } from 'tgui-core/components';
import { Window } from '../layouts';

type Coterie = {
  key: string;
  name: string;
  leader_name: string;
  member_count: number;
};

type Data = {
  coteries: Coterie[];
};

export const CoterieAdmin = (props) => {
  const { act, data } = useBackend<Data>();
  const { coteries = [] } = data;

  return (
    <Window title="Coterie Admin" width={400} height={500}>
      <Window.Content>
        <Section title="Active Coteries" fill scrollable>
          <Table>
            <Table.Row header>
              <Table.Cell>Name</Table.Cell>
              <Table.Cell>Leader</Table.Cell>
              <Table.Cell>Members</Table.Cell>
              <Table.Cell />
            </Table.Row>
            {coteries.map((coterie) => (
              <Table.Row key={coterie.key}>
                <Table.Cell>{coterie.name}</Table.Cell>
                <Table.Cell>{coterie.leader_name}</Table.Cell>
                <Table.Cell>{coterie.member_count}</Table.Cell>
                <Table.Cell>
                  <Button
                    icon="eye"
                    onClick={() => act('open_coterie', { key: coterie.key })}
                  >
                    View
                  </Button>
                </Table.Cell>
              </Table.Row>
            ))}
            {coteries.length === 0 && (
              <Table.Row>
                <Table.Cell colSpan={4} style={{ textAlign: 'center', padding: '8px' }}>
                  No active coteries this round.
                </Table.Cell>
              </Table.Row>
            )}
          </Table>
        </Section>
      </Window.Content>
    </Window>
  );
};
