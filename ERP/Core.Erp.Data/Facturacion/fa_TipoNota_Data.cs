using Core.Erp.Info.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Facturacion
{
    public class fa_TipoNota_Data
    {
        public List<fa_TipoNota_Info> get_list(bool mostrar_anulados)
        {
            try
            {
                List<fa_TipoNota_Info> Lista;
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    if (mostrar_anulados)
                        Lista = (from q in Context.fa_TipoNota
                                 select new fa_TipoNota_Info
                                 {
                                     IdTipoNota = q.IdTipoNota,
                                     CodTipoNota = q.CodTipoNota,
                                     No_Descripcion = q.No_Descripcion,
                                     Tipo = q.Tipo,
                                     Estado = q.Estado,

                                     EstadoBool = q.Estado == "A" ? true : false
                                 }).ToList();
                    else

                        Lista = (from q in Context.fa_TipoNota
                                 where q.Estado == "A"
                                 select new fa_TipoNota_Info
                                 {
                                     IdTipoNota = q.IdTipoNota,
                                     CodTipoNota = q.CodTipoNota,
                                     No_Descripcion = q.No_Descripcion,
                                     Tipo = q.Tipo,
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
        public List<fa_TipoNota_Info> get_list( string Tipo, bool mostrar_anulados)
        {
            try
            {
                List<fa_TipoNota_Info> Lista;
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    if(mostrar_anulados)
                    Lista = (from q in Context.fa_TipoNota
                             where q.Tipo == Tipo
                             select new fa_TipoNota_Info
                             {
                                 IdTipoNota = q.IdTipoNota,
                                 CodTipoNota = q.CodTipoNota,
                                 No_Descripcion = q.No_Descripcion,
                                 Tipo = q.Tipo,
                                 Estado = q.Estado,

                                 EstadoBool = q.Estado == "A" ? true : false
                             }).ToList();
                    else
                    {
                        Lista = (from q in Context.fa_TipoNota
                                 where q.Tipo == Tipo
                                 && q.Estado=="A"
                                 select new fa_TipoNota_Info
                                 {
                                     IdTipoNota = q.IdTipoNota,
                                     CodTipoNota = q.CodTipoNota,
                                     No_Descripcion = q.No_Descripcion,
                                     Tipo = q.Tipo,
                                     Estado = q.Estado,

                                     EstadoBool = q.Estado == "A" ? true : false
                                 }).ToList();
                    }
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public fa_TipoNota_Info get_info(int IdTipoNota)
        {
            try
            {
                fa_TipoNota_Info info = new fa_TipoNota_Info();
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    fa_TipoNota Entity = Context.fa_TipoNota.FirstOrDefault(q => q.IdTipoNota == IdTipoNota);
                    if (Entity == null) return null;
                    info = new fa_TipoNota_Info
                    {
                        IdTipoNota = Entity.IdTipoNota,
                        CodTipoNota = Entity.CodTipoNota,
                        No_Descripcion = Entity.No_Descripcion,
                        Tipo = Entity.Tipo,
                        Estado = Entity.Estado,
                        GeneraMoviInven = Entity.GeneraMoviInven == null ? false : Convert.ToBoolean(Entity.GeneraMoviInven)
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
        private int get_id()
        {

            try
            {
                int ID = 1;
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    var lst = from q in Context.fa_TipoNota
                              select q;
                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdTipoNota) + 1;
                }
                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(fa_TipoNota_Info info)
        {
            try
            {
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    fa_TipoNota Entity = new fa_TipoNota
                    {

                        IdTipoNota = info.IdTipoNota=get_id(),
                        CodTipoNota = info.CodTipoNota,
                        No_Descripcion = info.No_Descripcion,
                        Tipo = info.Tipo,
                        Estado = info.Estado="A",
                        GeneraMoviInven = info.GeneraMoviInven,

                        IdUsuario = info.IdUsuario,
                        Fecha_Transac = DateTime.Now
                    };
                    Context.fa_TipoNota.Add(Entity);
                    foreach (var item in info.Lst_fa_TipoNota_x_Empresa_x_Sucursal)
                    {
                        fa_TipoNota_x_Empresa_x_Sucursal det = new fa_TipoNota_x_Empresa_x_Sucursal
                        {
                            IdEmpresa = info.IdEmpresa,
                            IdSucursal = item.IdSucursal,
                            IdTipoNota = info.IdTipoNota,
                            IdCtaCble = item.IdCtaCble
                        };
                        Context.fa_TipoNota_x_Empresa_x_Sucursal.Add(det);
                    }
                        Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(fa_TipoNota_Info info)
        {
            try
            {
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    fa_TipoNota Entity = Context.fa_TipoNota.FirstOrDefault(q => q.IdTipoNota == info.IdTipoNota);
                    if (Entity == null) return false;

                    Entity.CodTipoNota = info.CodTipoNota;
                    Entity.No_Descripcion = info.No_Descripcion;
                    Entity.Tipo = info.Tipo;
                    Entity.GeneraMoviInven = info.GeneraMoviInven;

                    Entity.IdUsuarioUltMod = info.IdUsuarioUltMod;
                    Entity.Fecha_UltMod = DateTime.Now;
                    
                    var lst = Context.fa_TipoNota_x_Empresa_x_Sucursal.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdTipoNota == info.IdTipoNota).ToList();
                    foreach (var item in lst)
                    {
                        Context.fa_TipoNota_x_Empresa_x_Sucursal.Remove(item);
                    }
                    foreach (var item in info.Lst_fa_TipoNota_x_Empresa_x_Sucursal)
                    {
                        fa_TipoNota_x_Empresa_x_Sucursal det = new fa_TipoNota_x_Empresa_x_Sucursal
                        {
                            IdEmpresa = info.IdEmpresa,
                            IdSucursal = item.IdSucursal,
                            IdTipoNota = info.IdTipoNota, 
                            IdCtaCble = item.IdCtaCble
                        };
                        Context.fa_TipoNota_x_Empresa_x_Sucursal.Add(det);
                    }


                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception e)
            {

                throw;
            }
        }
        public bool anularDB(fa_TipoNota_Info info)
        {
            try
            {
                using (Entities_facturacion Context = new Entities_facturacion())
                {
                    fa_TipoNota Entity = Context.fa_TipoNota.FirstOrDefault(q => q.IdTipoNota == info.IdTipoNota);
                    if (Entity == null) return false;

                    Entity.Estado = info.Estado="I";

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
