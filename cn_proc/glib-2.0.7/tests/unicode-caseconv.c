#undef G_DISABLE_ASSERT
#undef G_LOG_DOMAIN

#include <locale.h>
#include <stdlib.h>
#include <stdio.h>
#include <glib.h>
#include <string.h>

int main (int argc, char **argv)
{
  FILE *infile;
  char buffer[1024];
  char **strings;
  char *srcdir = getenv ("srcdir");
  char *filename;
  const char *locale;
  const char *test;
  char *convert;
  char *current_locale = setlocale (LC_CTYPE, NULL);
  gint result = 0;

  if (!srcdir)
    srcdir = ".";
  filename = g_strconcat (srcdir, G_DIR_SEPARATOR_S, "casemap.txt", NULL);
  
  infile = fopen (filename, "r");
  if (!infile)
    {
      fprintf (stderr, "Failed to open %s\n", filename );
      exit (1);
    }
  
  while (fgets (buffer, sizeof(buffer), infile))
    {
      if (buffer[0] == '#')
	continue;

      strings = g_strsplit (buffer, "\t", -1);

      locale = strings[0];

      if (!locale[0])
	locale = "C";
	
      if (strcmp (locale, current_locale) != 0)
	{
	  setlocale (LC_CTYPE, locale);
	  current_locale = setlocale (LC_CTYPE, NULL);

	  if (strncmp (current_locale, locale, 2) != 0)
	    {
	      fprintf (stderr, "Cannot set locale to %s, skipping\n", locale);
	      goto next;
	    }
	}
      
      test = strings[1];

      convert = g_utf8_strup (test, -1);
      if (strcmp (convert, strings[4]) != 0)
	{
	  fprintf (stderr, "Failure: toupper(%s) == %s, should have been %s\n",
		   test, convert, strings[4]);
	  result = 1;
	}
      g_free (convert);

      convert = g_utf8_strdown (test, -1);
      if (strcmp (convert, strings[2]) != 0)
	{
	  fprintf (stderr, "Failure: tolower(%s) == %s, should have been %s\n",
		   test, convert, strings[2]);
	  result = 1;
	}
      g_free (convert);

    next:
      g_strfreev (strings);
    }

  fclose (infile);

  g_free (filename);
  filename = g_strconcat (srcdir, G_DIR_SEPARATOR_S, "casefold.txt", NULL);
  
  infile = fopen (filename, "r");
  if (!infile)
    {
      fprintf (stderr, "Failed to open %s\n", filename );
      exit (1);
    }
  
  while (fgets (buffer, sizeof(buffer), infile))
    {
      if (buffer[0] == '#')
	continue;

      buffer[strlen(buffer) - 1] = '\0';
      strings = g_strsplit (buffer, "\t", -1);

      test = strings[0];

      convert = g_utf8_casefold (test, -1);
      if (strcmp (convert, strings[1]) != 0)
	{
	  fprintf (stderr, "Failure: casefold(%s) == '%s', should have been '%s'\n",
		   test, convert, strings[1]);
	  result = 1;
	}
      g_free (convert);

      g_strfreev (strings);
    }

  fclose (infile);

  return result;
}
