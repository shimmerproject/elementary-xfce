/*-
 * vi:set et ai sts=2 sw=2 cindent:
 *
 * Copyright (c) 2012 Nick Schermer <nick@xfce.org>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>

#include <gdk-pixbuf/gdk-pixbuf.h>


static void
svgtopng (const gchar *src)
{
  gchar *dest;
  gchar *tmp;
  GdkPixbuf *pix;
  gchar *link;
  gchar *newlink;
  GError *error = NULL;
  gchar *dirname;
  gchar *basename;
  gint icon_size;

  if (!g_str_has_suffix (src, ".svg"))
    return;

  /* get parent directory name */
  dirname = g_path_get_dirname (src);
  basename = g_path_get_basename (dirname);
  g_free (dirname);
  if (basename == NULL)
    return;

  /* to go get an icon size */
  icon_size = atoi (basename);
  g_free (basename);
  if (icon_size == 0)
    {
      g_message ("Unable to extract icon size from directory name %s", src);
      return;
    }

  tmp = g_strndup (src, strlen (src) - 3);
  dest = g_strconcat (tmp, "png", NULL);
  g_free (tmp);

  if (!g_file_test (dest, G_FILE_TEST_EXISTS))
    {
      if (g_file_test (src, G_FILE_TEST_IS_SYMLINK))
        {
          link = g_file_read_link (src, NULL);
          if (link
              && g_str_has_suffix (link, ".svg"))
            {
              tmp = g_strndup (link, strlen (link) - 3);
              newlink = g_strconcat (tmp, "png", NULL);
              g_free (tmp);

              if (symlink (newlink, dest) == -1)
                g_message ("failed to create symlink: %s", g_strerror (errno));

              g_free (newlink);
            }
          g_free (link);
        }
      else
        {
          pix = gdk_pixbuf_new_from_file (src, &error);
          if (pix)
            {
              if (gdk_pixbuf_get_width (pix) > icon_size
                  || gdk_pixbuf_get_height (pix) > icon_size)
                {
                  g_message ("Skipping %s, size too big (%dx%d instead of %dx%d)",
                             dest, gdk_pixbuf_get_width (pix),
                             gdk_pixbuf_get_height (pix),
                             icon_size, icon_size);

                  g_object_unref (pix);
                  return;
                }

              if (!gdk_pixbuf_save (pix, dest, "png", &error, NULL))
                {
                  g_message ("Failed to save pixmap to %s: %s", dest, error->message);
                  g_error_free (error);
                }
              g_object_unref (pix);
            }
          else
            {
              g_message ("Failed to load svg %s: %s", src, error->message);
              g_error_free (error);
            }
        }
    }

  g_free (dest);
}


gint
main (gint    argc,
      gchar **argv)
{
  gint i;

  for (i = 1; i < argc; i++)
    svgtopng (argv[i]);

  return EXIT_SUCCESS;
}
