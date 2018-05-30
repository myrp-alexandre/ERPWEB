using Core.Erp.Info.SeguridadAcceso;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.SeguridadAcceso
{
    public class seg_usuario_Data
    {
        public List<seg_usuario_Info> get_list(bool mostrar_anulados)
        {
            try
            {
                List<seg_usuario_Info> Lista;

                using (Entities_seguridad_acceso Context = new Entities_seguridad_acceso())
                {
                    if(mostrar_anulados)
                    Lista = (from q in Context.seg_usuario
                             select new seg_usuario_Info
                             {
                                 IdUsuario = q.IdUsuario,
                                 estado = q.estado,
                                 Nombre = q.Nombre,
                             }).ToList();
                    else
                        Lista = (from q in Context.seg_usuario
                                 where q.estado == "A"
                                 select new seg_usuario_Info
                                 {
                                     IdUsuario = q.IdUsuario,
                                     estado = q.estado,
                                     Nombre = q.Nombre,
                                 }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public seg_usuario_Info validar_login(string IdUsuario, string contrasena)
        {
            try
            {
                seg_usuario_Info info = new seg_usuario_Info();
                using (Entities_seguridad_acceso Context = new Entities_seguridad_acceso())
                {
                    seg_usuario Entity = Context.seg_usuario.FirstOrDefault(q => q.IdUsuario == IdUsuario && q.Contrasena == contrasena && q.estado == "A");
                    if (Entity == null) return null;
                    info = new seg_usuario_Info
                    {
                        IdUsuario = Entity.IdUsuario,
                        Contrasena = Entity.Contrasena,
                        CambiarContraseniaSgtSesion = Entity.CambiarContraseniaSgtSesion == null ? false : Convert.ToBoolean(Entity.CambiarContraseniaSgtSesion)
                    };
                                    
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool validar_existe_usuario(string IdUsuario)
        {
            try
            {
                using (Entities_seguridad_acceso Context = new Entities_seguridad_acceso())
                {
                    var lst = from q in Context.seg_usuario
                              where q.IdUsuario == IdUsuario
                              select q;

                    if (lst.Count() > 0)
                        return true;
                    else
                        return false;
                }
            }
            catch (Exception)
            {

                throw;
            }
        }

        public seg_usuario_Info get_info(string IdUsuario)
        {
            try
            {
                seg_usuario_Info info = new seg_usuario_Info();

                using (Entities_seguridad_acceso Context = new Entities_seguridad_acceso())
                {
                    seg_usuario Entity = Context.seg_usuario.FirstOrDefault(q => q.IdUsuario == IdUsuario);
                    if (Entity == null) return null;
                    info = new seg_usuario_Info
                    {
                        IdUsuario = Entity.IdUsuario,
                        Contrasena = Entity.Contrasena,
                        estado = Entity.estado,
                        Nombre = Entity.Nombre,
                        ExigirDirectivaContrasenia = Entity.ExigirDirectivaContrasenia == null ? false : Convert.ToBoolean(Entity.ExigirDirectivaContrasenia),
                        CambiarContraseniaSgtSesion = Entity.CambiarContraseniaSgtSesion == null ? false : Convert.ToBoolean(Entity.CambiarContraseniaSgtSesion)
                    };
                }

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(seg_usuario_Info info)
        {
            try
            {
                using (Entities_seguridad_acceso Context = new Entities_seguridad_acceso())
                {
                    seg_usuario Entity = new seg_usuario
                    {
                        IdUsuario = info.IdUsuario,
                        Contrasena = info.Contrasena,
                        ExigirDirectivaContrasenia = info.ExigirDirectivaContrasenia,
                        CambiarContraseniaSgtSesion = info.CambiarContraseniaSgtSesion,
                        Nombre = info.Nombre,
                        estado = info.estado = "A",

                        Fecha_Transaccion = info.Fecha_Transaccion
                    };
                    Context.seg_usuario.Add(Entity);
                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(seg_usuario_Info info)
        {
            try
            {
                using (Entities_seguridad_acceso Context = new Entities_seguridad_acceso())
                {
                    seg_usuario Entity = Context.seg_usuario.FirstOrDefault(q => q.IdUsuario == info.IdUsuario);
                    if (Entity == null) return false;
                    Entity.Nombre = info.Nombre;
                    Entity.CambiarContraseniaSgtSesion = info.CambiarContraseniaSgtSesion;
                    Entity.ExigirDirectivaContrasenia = info.ExigirDirectivaContrasenia;

                    Entity.IdUsuarioUltModi = info.IdUsuarioUltModi;
                    Entity.Fecha_UltMod = info.Fecha_UltMod;
                    Context.SaveChanges();
                }               

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(string IdUsuario, string old_Contrasena, string new_Contrasena)
        {
            try
            {
                using (Entities_seguridad_acceso Context = new Entities_seguridad_acceso())
                {
                    seg_usuario Entity = Context.seg_usuario.FirstOrDefault(q => q.IdUsuario == IdUsuario && q.Contrasena == old_Contrasena && q.estado == "A");
                    if(Entity == null)
                       return false;                    
                    Entity.Contrasena = new_Contrasena;
                    Entity.CambiarContraseniaSgtSesion = false;
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool anularDB(seg_usuario_Info info)
        {
            try
            {
                using (Entities_seguridad_acceso Context = new Entities_seguridad_acceso())
                {
                    seg_usuario Entity = Context.seg_usuario.FirstOrDefault(q => q.IdUsuario == info.IdUsuario);
                    if (Entity == null) return false;
                    Entity.estado = info.estado = "I";

                    Entity.IdUsuarioUltAnu = info.IdUsuarioUltAnu;
                    Entity.Fecha_UltAnu = info.Fecha_UltAnu;
                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
