using Core.Erp.Info.Compras;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Compras
{
    public class com_TerminoPago_Data
    {
        public List<com_TerminoPago_Info> get_list(bool mostrar_anulados)
        {
            try
            {
                List<com_TerminoPago_Info> Lista;
                using (Entities_compras Context = new Entities_compras())
                {
                    if (mostrar_anulados)
                        Lista = (from q in Context.com_TerminoPago
                                 select new com_TerminoPago_Info
                                 {
                                     IdTerminoPago = q.IdTerminoPago,
                                     Descripcion = q.Descripcion,
                                     Dias = q.Dias,
                                     Estado = q.Estado,

                                     EstadoBool = q.Estado == "A" ? true : false
                                 }).ToList();
                    else
                        Lista = (from q in Context.com_TerminoPago
                                 where q.Estado == "A"
                                 select new com_TerminoPago_Info
                                 {
                                     IdTerminoPago = q.IdTerminoPago,
                                     Descripcion = q.Descripcion,
                                     Dias = q.Dias,
                                     Estado = q.Estado,

                                     EstadoBool = q.Estado == "A" ? true : false
                                 }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public com_TerminoPago_Info get_info(string IdTerminoPago)
        {
            try
            {
                com_TerminoPago_Info info = new com_TerminoPago_Info();
                using (Entities_compras Context = new Entities_compras())
                {
                    com_TerminoPago Entity = Context.com_TerminoPago.Where(q => q.IdTerminoPago == IdTerminoPago).FirstOrDefault();
                    if (Entity == null) return null;

                    info = new com_TerminoPago_Info
                    {
                        IdTerminoPago = Entity.IdTerminoPago,
                        Descripcion = Entity.Descripcion,
                        Dias = Entity.Dias,
                        Estado = Entity.Estado
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool validar_existe_idTermino(string IdTerminoPago)
        {
            try
            {
                using (Entities_compras Context = new Entities_compras())
                {
                    var lst = from q in Context.com_TerminoPago
                              where q.IdTerminoPago == IdTerminoPago
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

        public bool guardarDB(com_TerminoPago_Info info)
        {
            try
            {
                using (Entities_compras Context = new Entities_compras())
                {
                    com_TerminoPago Entity = new com_TerminoPago
                    {
                        IdTerminoPago = info.IdTerminoPago,
                        Descripcion = info.Descripcion,
                        Dias = info.Dias,
                        Estado = "A",
                        IdUsuario = info.IdUsuario

                    };
                    Context.com_TerminoPago.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(com_TerminoPago_Info info)
        {
            try
            {
                using (Entities_compras Context = new Entities_compras())
                {
                    com_TerminoPago Entity = Context.com_TerminoPago.Where(q => q.IdTerminoPago == info.IdTerminoPago).FirstOrDefault();
                    if (Entity == null) return false;

                    Entity.Descripcion = info.Descripcion;
                    Entity.Dias = info.Dias;
                    Entity.IdUsuarioUltMod = info.IdUsuarioUltMod;
                    Entity.FechaUltMod = DateTime.Now;
                    
                Context.SaveChanges();

            }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool anularDB(com_TerminoPago_Info info)
        {
            try
            {
                using (Entities_compras Context = new Entities_compras())
                {
                    com_TerminoPago Entity = Context.com_TerminoPago.Where(q => q.IdTerminoPago == info.IdTerminoPago).FirstOrDefault();
                    if (Entity == null) return false;

                    Entity.Estado = "I";
                    Entity.IdUsuarioUltAnu = info.IdUsuarioUltAnu;
                    Entity.Fecha_UltAnu = DateTime.Now;

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
