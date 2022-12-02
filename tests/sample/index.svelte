<!-- code example from https://svelte.dev/tutorial/svelte-component -->

<!-- RESULT OF JOIN (node "self_closing_tag", preset default) -->
<svelte:component this={selected.component}/>

<!-- RESULT OF SPLIT (node "self_closing_tag", preset default) -->
<svelte:component
  this={selected.component}
/>

<!-- RESULT OF JOIN (node "element", preset default) -->
<RedThing>Text</RedThing>

<!-- RESULT OF SPLIT (node "element", preset default) -->
<RedThing>
  Text
</RedThing>
