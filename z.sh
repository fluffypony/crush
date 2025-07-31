#!/bin/bash

cat > /tmp/golden_files_sql.sql << 'EOF'
-- SQL script to insert descriptions for all .golden test files
-- Generated for project ID: 88ae92ca-8f84-4788-830e-eb6c1318556e

INSERT OR IGNORE INTO file_descriptions (project_id, file_path, description, last_modified, version) VALUES
EOF

# Core component golden files
find /Users/ric/Desktop/working/crush -path "*/tui/components/core/testdata/*" -name "*.golden" | sed 's|/Users/ric/Desktop/working/crush/||' | while read file; do
    echo "('88ae92ca-8f84-4788-830e-eb6c1318556e', '$file', '[GOLDEN TEST FILE] Expected terminal output for core status component test. Contains ANSI-escaped text with colors and formatting for automated visual regression testing. Used to verify consistent rendering of status displays across different configurations. Part of the TUI component testing suite ensuring UI consistency.', CURRENT_TIMESTAMP, 1)," >> /tmp/golden_files_sql.sql
done

# List component golden files
find /Users/ric/Desktop/working/crush -path "*/tui/exp/list/testdata/*" -name "*.golden" | sed 's|/Users/ric/Desktop/working/crush/||' | while read file; do
    echo "('88ae92ca-8f84-4788-830e-eb6c1318556e', '$file', '[GOLDEN TEST FILE] Expected terminal output for list component test. Contains ANSI-escaped text showing list rendering with proper positioning, scrolling, and item management. Used to verify consistent visual output of the list component under various interaction scenarios. Part of the experimental TUI list testing suite ensuring UI consistency.', CURRENT_TIMESTAMP, 1)," >> /tmp/golden_files_sql.sql
done

# Diffview component golden files
find /Users/ric/Desktop/working/crush -path "*/tui/exp/diffview/testdata/*" -name "*.golden" | sed 's|/Users/ric/Desktop/working/crush/||' | while read file; do
    echo "('88ae92ca-8f84-4788-830e-eb6c1318556e', '$file', '[GOLDEN TEST FILE] Expected terminal output for diffview component test. Contains ANSI-escaped text showing diff rendering with syntax highlighting, line numbers, and layout formatting. Used to verify consistent visual output of the diff display component under various configurations (width, height, offset, split/unified modes). Part of the experimental TUI diffview testing suite ensuring UI consistency.', CURRENT_TIMESTAMP, 1)," >> /tmp/golden_files_sql.sql
done

# Remove the trailing comma from the last line and add semicolon
# On macOS, sed -i requires a backup extension. Use '' for no backup.
sed -i '' '$ s/,$/;/' /tmp/golden_files_sql.sql

cat /tmp/golden_files_sql.sql
