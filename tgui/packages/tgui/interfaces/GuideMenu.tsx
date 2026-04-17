// THIS IS A TFN UI FILE
import { useState, useEffect, useRef } from 'react';
import type { ReactNode } from 'react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { sanitizeText } from '../sanitize';

type GuideTab = {
  name: string;
  html_content: string;
};

type GuideMenuData = {
  tabs: GuideTab[];
  is_admin: boolean;
  show_on_spawn: boolean;
};

export const GuideMenu = () => {
  const { act, data } = useBackend<GuideMenuData>();
  const { tabs = [], is_admin, show_on_spawn } = data;

  const [selectedTab, setSelectedTab] = useState(0);
  const [editingContent, setEditingContent] = useState(false);
  const [draftContent, setDraftContent] = useState('');
  const [showAdminTools, setShowAdminTools] = useState(true);
  const contentRef = useRef<HTMLDivElement>(null);

  const adminActive = is_admin && showAdminTools;

  const safeIndex = Math.min(selectedTab, Math.max(0, tabs.length - 1));
  const currentTab = tabs[safeIndex];

  useEffect(() => {
    if (contentRef.current && currentTab && !editingContent) {
      contentRef.current.innerHTML = sanitizeText(
        currentTab.html_content.replace(/\n/g, '<br>'),
        true,
        undefined,
        ['background'],
        ['img', 'iframe', 'style'],
      );
    }
  }, [safeIndex, currentTab?.html_content, editingContent]);

  const handleTabSelect = (index: number) => {
    if (editingContent) return;
    setSelectedTab(index);
  };

  const handleEditContent = () => {
    setDraftContent(currentTab?.html_content ?? '');
    setEditingContent(true);
  };

  const handleSaveContent = () => {
    act('set_content', {
      tab_index: safeIndex + 1,
      html_content: draftContent,
    });
    setEditingContent(false);
  };

  return (
    <Window width={currentTab?.name === 'Wiki' ? 1300 : 920} height={660} title="Guide">
      <Window.Content
        fitted
        style={{
          display: 'flex',
          flexDirection: 'row',
          height: '100%',
          overflow: 'hidden',
        }}
      >
        <div
          style={{
            width: '210px',
            minWidth: '210px',
            display: 'flex',
            flexDirection: 'column',
            background: 'rgba(10, 10, 10, 0.9)',
            borderRight: '1px solid #3a3a3a',
            overflow: 'hidden',
          }}
        >
          <div
            style={{
              padding: '10px 14px',
              fontWeight: 'bold',
              fontSize: '11px',
              color: '#ddd',
              letterSpacing: '0.08em',
              textTransform: 'uppercase',
              borderBottom: '1px solid #3a3a3a',
              flexShrink: 0,
            }}
          >
            Sections
          </div>

          <div style={{ flex: 1, overflowY: 'auto' }}>
            {tabs.length === 0 && (
              <div
                style={{
                  padding: '14px',
                  color: '#ddd',
                  fontSize: '13px',
                  fontStyle: 'italic',
                }}
              >
                No sections yet.
              </div>
            )}
            {tabs.map((tab, i) => (
              <div
                key={i}
                style={{
                  borderLeft: `3px solid ${i === safeIndex ? '#ddd' : 'transparent'}`,
                  background: i === safeIndex ? '#262626' : 'transparent',
                  transition: 'background 0.1s',
                }}
              >
                <div
                  style={{
                    display: 'flex',
                    alignItems: 'center',
                    padding: '0 6px 0 10px',
                    minHeight: '36px',
                  }}
                >
                  <span
                    onClick={() => handleTabSelect(i)}
                    style={{
                      flex: 1,
                      padding: '8px 4px',
                      cursor: editingContent ? 'default' : 'pointer',
                      color: i === safeIndex ? '#ddd' : '#ddd',
                      fontSize: '13px',
                      whiteSpace: 'nowrap',
                      overflow: 'hidden',
                      textOverflow: 'ellipsis',
                      userSelect: 'none',
                    }}
                  >
                    {tab.name}
                  </span>

                  {adminActive && !editingContent && (
                    <div style={{ display: 'flex', gap: '1px', flexShrink: 0 }}>
                      <SidebarButton
                        title="Move up"
                        disabled={i === 0}
                        onClick={() => {
                          act('move_tab', { tab_index: i + 1, direction: 'up' });
                          if (selectedTab === i) setSelectedTab(i - 1);
                          else if (selectedTab === i - 1) setSelectedTab(i);
                        }}
                      >
                        ^
                      </SidebarButton>
                      <SidebarButton
                        title="Move down"
                        disabled={i === tabs.length - 1}
                        onClick={() => {
                          act('move_tab', { tab_index: i + 1, direction: 'down' });
                          if (selectedTab === i) setSelectedTab(i + 1);
                          else if (selectedTab === i + 1) setSelectedTab(i);
                        }}
                      >
                        v
                      </SidebarButton>
                      <SidebarButton
                        title="Rename section"
                        onClick={() => {
                          setSelectedTab(i);
                          act('rename_tab', { tab_index: i + 1 });
                        }}
                      >
                        rename
                      </SidebarButton>
                      <SidebarButton
                        title="Delete section"
                        danger
                        onClick={() =>
                          act('delete_tab', { tab_index: i + 1 })
                        }
                      >
                        delete
                      </SidebarButton>
                    </div>
                  )}
                </div>
              </div>
            ))}
          </div>

          {adminActive && (
            <div
              style={{
                padding: '8px',
                borderTop: '1px solid #3a3a3a',
                flexShrink: 0,
              }}
            >
              <button
                onClick={() => act('add_tab')}
                disabled={editingContent}
                style={{
                  width: '100%',
                  padding: '6px',
                  background: 'transparent',
                  border: '1px solid #ddd',
                  color: editingContent ? '#444' : '#ddd',
                  cursor: editingContent ? 'default' : 'pointer',
                  fontSize: '12px',
                  borderRadius: '3px',
                }}
              >
                Add Section
              </button>
            </div>
          )}
        </div>

        <div
          style={{
            flex: 1,
            display: 'flex',
            flexDirection: 'column',
            overflow: 'hidden',
            minWidth: 0,
            background: 'rgba(10, 10, 10, 0.85)',
          }}
        >
          {is_admin && (
            <div
              style={{
                display: 'flex',
                alignItems: 'center',
                gap: '8px',
                padding: '5px 12px',
                background: '#1a1a1a',
                borderBottom: '1px solid #3a3a3a',
                flexShrink: 0,
                fontSize: '12px',
              }}
            >
              <span
                style={{
                  color: '#ddd',
                  fontWeight: 'bold',
                  letterSpacing: '0.05em',
                }}
              >
                Server Guide
              </span>
              {adminActive && currentTab && (
                editingContent ? (
                  <>
                    <ToolbarButton
                      color="#ddd"
                      bg="#222"
                      border="#ddd"
                      onClick={handleSaveContent}
                    >
                      Save
                    </ToolbarButton>
                    <ToolbarButton
                      color="#ddd"
                      bg="#222"
                      border="#ddd"
                      onClick={() => setEditingContent(false)}
                    >
                      Cancel
                    </ToolbarButton>
                    <span style={{ color: '#ddd', fontStyle: 'italic' }}>
                      Editing HTML for "{currentTab.name}"
                    </span>
                  </>
                ) : (
                  <ToolbarButton
                    color="#ddd"
                    bg="#222"
                    border="#ddd"
                    onClick={handleEditContent}
                  >
                    Edit Content
                  </ToolbarButton>
                )
              )}

              <div style={{ flex: 1 }} />

              <ToolbarButton
                color="#ddd"
                bg="#222"
                border="#ddd"
                onClick={() => {
                  setShowAdminTools((v) => !v);
                  setEditingContent(false);
                }}
              >
                {showAdminTools ? 'Admin View' : 'Player View'}
              </ToolbarButton>
            </div>
          )}

          <div
            style={{
              flex: 1,
              overflow: 'auto',
              padding: editingContent ? '0' : '22px 28px',
              boxSizing: 'border-box',
            }}
          >
            {!currentTab ? (
              <div
                style={{
                  color: '#ddd',
                  fontStyle: 'italic',
                  padding: '20px',
                }}
              >
                {adminActive
                  ? 'someone deleted all the GOD DAMN SECTIONS TELL NIMI'
                  : 'AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH'}
              </div>
            ) : editingContent ? (
              <textarea // the main content area
                value={draftContent}
                onChange={(e) => setDraftContent(e.target.value)}
                spellCheck={false}
                style={{
                  width: '100%',
                  height: '100%',
                  background: '#111',
                  color: '#ddd',
                  border: 'none',
                  fontFamily: '"Consolas", "Courier New", monospace',
                  fontSize: '13px',
                  resize: 'none',
                  padding: '16px',
                  boxSizing: 'border-box',
                  outline: 'none',
                  lineHeight: '1.5',
                  display: 'block',
                }}
              />
            ) : (
              <div
                ref={contentRef}
                onMouseDown={(e) => e.stopPropagation()}
                style={{
                  color: '#ddd',
                  lineHeight: '1.7',
                  fontSize: '14px',
                  maxWidth: '740px',
                  userSelect: 'text',
                }}
              />
            )}
          </div>

          <div
            style={{
              padding: '6px 14px',
              borderTop: '1px solid #3a3a3a',
              background: '#1a1a1a',
              flexShrink: 0,
            }}
          >
            <label
              style={{
                display: 'flex',
                alignItems: 'center',
                gap: '6px',
                cursor: 'pointer',
                color: '#aaa',
                fontSize: '12px',
                userSelect: 'none',
              }}
            >
              <input
                type="checkbox"
                checked={!!show_on_spawn}
                onChange={() => act('toggle_show_on_spawn')}
              />
              Show this window on login
            </label>
          </div>
        </div>
      </Window.Content>
    </Window>
  );
};

type SidebarButtonProps = {
  children: ReactNode;
  onClick: () => void;
  title?: string;
  disabled?: boolean;
  danger?: boolean;
};

const SidebarButton = ({
  children,
  onClick,
  title,
  disabled,
  danger,
}: SidebarButtonProps) => (
  <button
    title={title}
    disabled={disabled}
    onClick={disabled ? undefined : onClick}
    style={{
      background: 'transparent',
      border: 'none',
      color: danger ? '#ddd' : '#ddd',
      cursor: disabled ? 'default' : 'pointer',
      padding: '2px 4px',
      fontSize: '11px',
      opacity: disabled ? 0.3 : 1,
      lineHeight: 1,
    }}
  >
    {children}
  </button>
);

type ToolbarButtonProps = {
  children: ReactNode;
  onClick: () => void;
  color: string;
  bg: string;
  border: string;
};

const ToolbarButton = ({
  children,
  onClick,
  color,
  bg,
  border,
}: ToolbarButtonProps) => (
  <button
    onClick={onClick}
    style={
      {
        padding: '3px 10px',
        background: bg,
        border: `1px solid ${border}`,
        color,
        cursor: 'pointer',
        fontSize: '12px',
        borderRadius: '3px',
      }
    }
  >
    {children}
  </button>
);
