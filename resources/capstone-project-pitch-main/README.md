# Capstone Project Pitch

A **project pitch** is a summary and outline of a proposed project. They're usually
written to give external stakeholders a overview of a project's purpose, intent,
technical requirements and/or limitations, and implementation strategy.

In this assignment, you'll create a project pitch for your capstone project based on a
our pitch template. You'll use a simple, widely-used markup language called Markdown to
write the pitch. Then, we'll compile all the pitches together and use the power of
programming to render a super cool packet to share with Walmart.

## Instructions

1. We use GitHub's Markdown syntax, which is a bit different from standard Markdown
   syntax. It's just as quick and easy to learn &mdash; [GitHub's Basic writing and
   formatting guide](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)
   is all you need to get started.
   - VS Code has a built-in Markdown preview. To use it, open the Command Palette (
     `View > Command Palette` or `Ctrl/Cmd + Shift - p`) and run
     `Markdown: Open Preview to the Side`.
1. Read about the subsections of the project pitch below so you understand the purpose of
   each one.
1. Refer to the example pitches in [`examples/`](examples) to get an idea of how the
   completed pitch should look.
1. Write your pitch in [`project-pitch.md`](project-pitch.md) (it's a template &mdash;
   all you have to do is fill in your project information!)

## Required content

Your project pitch should include information in the following sections.

### Intro

One sentence summarizing the main idea behind your project.

### Background

Contextual information or prior art that helps to explain why or how you decided on an
idea. For example, you can mention the existing projects or applications that inspired you
or tell the story of how you came up with your idea. It's also a good opportunity to
showcase who you are and the types of things that interest you.

### MVP

The scope of your MVP as a list of 3&ndash;4 user stories. **User stories** are often
expressed in simple sentences with the following structure:

```
As a [user or persona], I [want to], [so that].
```

Breaking this down:

- **"As a [user or persona]":** Who are you building this for? In most cases, writing `As
  a user` is fine, but if your project addresses different *types* of users, you write
  something more specific like `As a writer` or `As an editor`.
- **"I [want to]":** Here you're describing their intent, not the features they use. What
  is it they're actually trying to achieve? This statement should be **implementation
  free** &mdash; don't describe any part of the UI and focus on the user's goal.
- **"[so that]":** How does their immediate desire to do something fit into their bigger
  picture? What's the overall benefit they're trying to achieve? What is the big problem
  that needs solving?

### Tech stack

You likely won't need to change the tech stack that's already described in the template,
but just in case, this is where you'll list the technologies and platforms that make up
your **data store**, **backend**, and **frontend.**

Below the tech stack, you'll list your project's **technical dependencies** &mdash; any
external, third-party packages you're planning to use in your project. You can mention
each dependency by name and, if it makes sense to, include a bit of context on how that
dependency will be used in your project.

### Roadmap

The lists of tasks and/or project components you're planning on building for Sprint 1 and
Sprint 2. This is where you talk about implementation details.
