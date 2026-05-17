#!/usr/bin/env python3
"""Check PR statuses from README and update badges if changed."""
import re
import subprocess
import json
import sys
import os

STATUS_MAP = {
    'OPEN': ('⏳', 'Pending'),
    'MERGED': ('✅', 'Merged'),
    'CLOSED': ('❌', 'Closed'),
}


def get_pr_status(repo, pr_num):
    """Fetch PR state from GitHub API via gh CLI."""
    result = subprocess.run(
        ['gh', 'pr', 'view', str(pr_num), '--repo', repo,
         '--json', 'state,mergedAt'],
        capture_output=True, text=True,
    )
    if result.returncode != 0:
        print(f'    ⚠ Could not fetch {repo}#{pr_num}')
        return None
    data = json.loads(result.stdout)
    state = data['state']
    merged_at = data.get('mergedAt')

    if state == 'OPEN':
        return 'OPEN'
    elif merged_at is not None:
        return 'MERGED'
    elif state == 'CLOSED':
        return 'CLOSED'
    return None


def extract_prs(text):
    """Return unique list of (repo, pr_number) from markdown text."""
    prs = re.findall(r'https://github\.com/([^/]+/[^/]+)/pull/(\d+)', text)
    return list(dict.fromkeys(prs))


def update_file(filepath, pr_statuses):
    """Replace status badges in a README file. Returns True if changed."""
    with open(filepath) as f:
        content = f.read()

    lines = content.split('\n')
    original = content

    for (repo, pr_num), status_key in pr_statuses.items():
        emoji, label = STATUS_MAP[status_key]
        pr_url = f'https://github.com/{repo}/pull/{pr_num}'

        # 1. Table rows: status column on same line as PR URL
        for i, line in enumerate(lines):
            if pr_url in line and line.strip().startswith('|'):
                lines[i] = re.sub(
                    r'\| ([✅⏳❌]) ([A-Za-z]+) \|',
                    f'| {emoji} {label} |',
                    line,
                )

        # 2. Highlight blocks: find Status line near PR URL in block
        for i, line in enumerate(lines):
            if pr_url in line and '- PR:' in line:
                for j in range(i - 1, max(i - 6, -1), -1):
                    if '- Status:' in lines[j]:
                        lines[j] = re.sub(
                            r'- Status: ([A-Za-z]+) ([✅⏳❌])',
                            f'- Status: {label} {emoji}',
                            lines[j],
                        )
                        break
                break

    new_content = '\n'.join(lines)
    if new_content != original:
        with open(filepath, 'w') as f:
            f.write(new_content)
        return True
    return False


def main():
    print('Checking PR statuses...')

    all_prs = set()
    for fp in ['README.md', 'README.id.md']:
        with open(fp) as f:
            all_prs.update(extract_prs(f.read()))

    if not all_prs:
        print('  No PRs found in README files')
        return

    pr_statuses = {}
    for repo, pr_num in sorted(all_prs):
        print(f'  Checking {repo}#{pr_num}...')
        status = get_pr_status(repo, pr_num)
        if status:
            pr_statuses[(repo, pr_num)] = status
            emoji, label = STATUS_MAP[status]
            print(f'    → {emoji} {label}')

    if not pr_statuses:
        print('  No statuses could be determined')
        return

    any_changed = False
    for fp in ['README.md', 'README.id.md']:
        if update_file(fp, pr_statuses):
            any_changed = True
            print(f'  Updated {fp}')

    if not any_changed:
        print('  No status changes needed')

    output_file = os.environ.get('GITHUB_OUTPUT')
    if output_file:
        with open(output_file, 'a') as f:
            f.write(f'changed={"true" if any_changed else "false"}\n')


if __name__ == '__main__':
    main()
