<template>
  <div>
    <!-- RESULT OF JOIN (node "start_tag", preset default) -->
    <app-line v-for="line in lines" :key="line">{{ line }}</app-line>

    <!-- RESULT OF SPLIT (node "start_tag", preset default) -->
    <app-line
      v-for="line in lines"
      :key="line"
    >{{ line }}</app-line>

    <!-- RESULT OF JOIN (node "self_closing_tag", preset default) -->
    <app-logo :class="css.headerLogo" id="logo"/>

    <!-- RESULT OF SPLIT (node "self_closing_tag", preset default) -->
    <app-logo
      :class="css.headerLogo"
      id="logo"
    />

    <!-- RESULT OF JOIN (node "element", preset default) -->
    <app-line v-for="line in lines" :key="line">{{ line }}</app-line>

    <!-- RESULT OF SPLIT (node "element", preset default) -->
    <app-line v-for="line in lines" :key="line">
      {{ line }}
    </app-line>
  </div>
</template>
