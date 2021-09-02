#!/usr/bin/env python3

from pathlib import Path
from typing import Callable, NoReturn, Optional, Union
import os
import platform
import readline
import shutil
import sys

Action = tuple[str, Callable[[], Union[None, NoReturn]]]


#


def colored(text: str, color: str) -> str:
    END = "\33[0m"
    return color + text + END


# Colors
RED = "\33[31m"
GREEN = "\33[32m"
BLUE = "\33[34m"

# Symbols
CROSS = colored("✗", RED)
TICK = colored("✓", GREEN)


#


def yn(question: str) -> bool:
    answer = input(f"{question} (y/N) ").strip()
    return answer.lower() in ["yes", "y"]


def really(func: Callable[[], None], question: str) -> None:
    if yn(question):
        func()
        print(colored(f"\tDone {TICK}", GREEN))
    else:
        print(colored(f"\tAborted {CROSS}", RED))


#


def rel(path: Path) -> str:
    try:
        return f"~/{path.relative_to(Path.home())}"
    except ValueError:
        return str(path)


def print_files(files: list[Path]) -> None:
    for file in files:
        symbol = TICK if file.exists() else CROSS
        text = colored(rel(file), BLUE) if file.is_dir() else rel(file)

        print(f"\t{text} {symbol}")


def delete_files(files: list[Path]) -> None:
    for file in files:
        if not file.exists():
            continue

        try:
            if file.is_dir():
                shutil.rmtree(file)
            else:
                os.remove(file)
        except OSError as e:
            print(colored(f"\tError: {rel(file)} - {e.strerror}", RED))


def search(
    root: Path,
    patterns: Optional[list[str]] = None,
    ignore_case: bool = False
) -> list[Path]:
    if not patterns:
        return list(root.rglob("*"))

    if ignore_case:
        f: Callable[[str], str] \
            = lambda c: f"[{c.lower()}{c.upper()}]" if c.isalpha() else c
        patterns = ["".join(map(f, p)) for p in patterns]

    files: list[Path] = []
    for p in patterns:
        files += root.rglob(p)

    return files


#


def print_and_delete(files: list[Path]) -> None:
    print_files(files)
    really(
        lambda: delete_files(files),
        "\n\tDo you really want to delete these files?"
    )


def search_and_delete(
    root: Optional[Path] = None,
    patterns: Optional[list[str]] = None,
    ignore_case: bool = False
) -> None:
    if root is None:
        while True:
            try:
                answer = input("\tRoot [~]: ").strip() or "~"
                root = Path(os.path.expandvars(answer)) \
                    .expanduser() \
                    .resolve(strict=True)
                break
            except (ValueError, FileNotFoundError):
                print(colored("\tPath not valid. Try again.\n", RED))

    if patterns is None:
        patterns = []
        while True:
            p = input(f"\tPattern #{len(patterns) + 1}: ").strip()
            if p:
                patterns.append(p)
            else:
                break

        if patterns:
            ignore_case = yn("\tIgnore case?")

    files = search(root, patterns, ignore_case)

    print()

    if files:
        print_and_delete(files)
    else:
        print(colored(f"\tNo files found {CROSS}", RED))


#


apple: list[str] = [
    "Assistant",
    "Caches",
    "Calendars",
    "Cookies",
    "Developer",
    "HTTPStorages",
    "LaunchAgents",
    "Logs",
    "Mail",
    "Maps",
    "Messages",
    "Metadata",
    "News",
    "Reminders",
    "Safari",
    "Saved Application State",
    "Spelling",
    "Suggestions",
    "SyncedPreferences",
    "WebKit",

    "Application Support/Caches",
    "Application Support/CloudDocs",
    "Application Support/com.apple.sharedfilelist",
    "Application Support/com.apple.spotlight",
    "Application Support/CrashReporter",
    "Application Support/Dock",
    "Application Support/FileProvider",

    "Preferences/.GlobalPreferences_m.plist",
    "Preferences/.GlobalPreferences.plist",
    "Preferences/ByHost",
    "Preferences/com.apple.dock.plist",
    "Preferences/com.apple.dt.Xcode.plist",
    "Preferences/com.apple.EmojiCache.plist",
    "Preferences/com.apple.EmojiPreferences.plist",
    "Preferences/com.apple.finder.plist",
    "Preferences/com.apple.mediaanalysisd.plist",
    "Preferences/com.apple.SFSymbols.plist",
    "Preferences/com.apple.Spotlight.plist",
    "Preferences/com.apple.Terminal.plist",
    "Preferences/com.apple.universalaccessAuthWarning.plist"
]

app: list[str] = [
    "Google",

    "Containers/net.pornel.ImageOptimizeExtension",
    "Group Containers/59KZTZA4XR.net.pornel.ImageOptim",

    "Application Scripts/net.pornel.ImageOptimizeExtension",

    "Application Support/Adobe",
    "Application Support/Code",
    "Application Support/Firefox",
    "Application Support/GitKraken",
    "Application Support/Google",
    "Application Support/JetBrains",
    "Application Support/Mozilla",
    "Application Support/Notion",
    "Application Support/obs-studio",
    "Application Support/Postman",
    "Application Support/Spotify",
    "Application Support/zoom.us",

    "Preferences/Adobe",
    "Preferences/ch.protonvpn.mac.plist",
    "Preferences/com.adobe.AdobeRdrCEFHelper.plist",
    "Preferences/com.adobe.crashreporter.plist",
    "Preferences/com.adobe.Reader.plist",
    "Preferences/com.axosoft.gitkraken.plist",
    "Preferences/com.google.Chrome.plist",
    "Preferences/com.google.Keystone.Agent.plist",
    "Preferences/com.jetbrains.toolbox.renderer.plist",
    "Preferences/com.microsoft.VSCode.plist",
    "Preferences/com.obsproject.obs-studio.plist",
    "Preferences/com.postmanlabs.mac.plist",
    "Preferences/com.spotify.client.plist",
    "Preferences/io.alacritty.plist",
    "Preferences/net.pornel.ImageOptim.plist",
    "Preferences/notion.id.plist",
    "Preferences/org.mozilla.firefoxdeveloperedition.plist",
    "Preferences/org.safeexambrowser.SafeExamBrowser.plist",
    "Preferences/us.zoom.xos.plist",
    "Preferences/ZoomChat.plist"
]


#


if __name__ == "__main__":
    print(f"OS: {platform.system()}")
    print(f"HOME: {Path.home()}\n")

    # Setup
    home = Path.home()
    library = home / "Library"

    apple_files = [library / file for file in apple]
    app_files = [library / file for file in app]

    # Actions
    actions: list[Action] = [
        ("Quit\n", sys.exit),

        ("Delete Apple files", lambda: print_and_delete(apple_files)),
        ("Delete App files", lambda: print_and_delete(app_files)),
        (
            "Delete 'Cache', 'Caches', 'Logs', 'Saved Application State' files\n",
            lambda: search_and_delete(
                library, ["Cache", "Caches", "Logs", "Saved Application State"]
            )
        ),

        (
            "Delete '.DS_Store' files\n",
            lambda: search_and_delete(home, [".DS_Store"])
        ),

        ("Search", lambda: search_and_delete())
    ]

    print("Actions:")
    for i, (name, _) in enumerate(actions):
        print(f"\t{i} - {name}")

    # Loop
    while True:
        try:
            answer = int(input("\n> "))
            if answer in range(0, len(actions)):
                try:
                    actions[answer][1]()
                except EOFError:
                    print(colored(f"\n\tAborted {CROSS}", RED))
            else:
                print(colored("\tOut of range. Try again.", RED))
        except ValueError:
            print(colored("\tEnter a valid number!", RED))
        except (EOFError, KeyboardInterrupt):
            sys.exit()
