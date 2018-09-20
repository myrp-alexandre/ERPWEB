using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.Inventario;
namespace Core.Erp.Data.Inventario
{
   public class in_Ing_Egr_Inven_distribucion_Data
    {
        public List<in_Ing_Egr_Inven_distribucion_Info> get_list(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo, decimal IdNumMovi)
        {
            try
            {
                List<in_Ing_Egr_Inven_distribucion_Info> Lista = new List<in_Ing_Egr_Inven_distribucion_Info>();

                using (Entities_inventario Context = new Entities_inventario())
                {
                    Lista = (from q in Context.in_Ing_Egr_Inven_distribucion
                             where q.IdEmpresa == IdEmpresa
                             && q.IdSucursal == IdSucursal
                             && q.IdMovi_inven_tipo == IdMovi_inven_tipo
                             && q.IdNumMovi == IdNumMovi
                             select new in_Ing_Egr_Inven_distribucion_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdMovi_inven_tipo = q.IdMovi_inven_tipo,
                                 IdNumMovi = q.IdNumMovi,
                                 secuencia_distribucion = q.secuencia_distribucion,
                                 IdEmpresa_dis = q.IdEmpresa_dis,
                                 IdSucursal_dis = q.IdSucursal_dis,
                                 IdMovi_inven_tipo_dis = q.IdMovi_inven_tipo_dis,
                                 IdNumMovi_dis = q.IdNumMovi_dis,
                                 estado = q.estado,
                                 signo = q.signo,
                             }).ToList();
                }

                return Lista;
            }
            catch (Exception )
            {
                throw;
            }
        }

        public in_Ing_Egr_Inven_distribucion_Info get_info(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo, decimal IdNumMovi, string signo)
        {
            in_Ing_Egr_Inven_distribucion_Info info = new in_Ing_Egr_Inven_distribucion_Info();

            try
            {
                using (Entities_inventario Context = new Entities_inventario())
                {
                    info = (from q in Context.in_Ing_Egr_Inven_distribucion
                            where q.IdEmpresa == IdEmpresa
                            && q.IdSucursal == IdSucursal
                            && q.IdMovi_inven_tipo == IdMovi_inven_tipo
                            && q.IdNumMovi == IdNumMovi
                            && q.signo == signo
                            && q.estado == true
                            select new in_Ing_Egr_Inven_distribucion_Info
                            {
                                IdEmpresa = q.IdEmpresa,
                                IdSucursal = q.IdSucursal,
                                IdMovi_inven_tipo = q.IdMovi_inven_tipo,
                                IdNumMovi = q.IdNumMovi,
                                secuencia_distribucion = q.secuencia_distribucion,
                                IdEmpresa_dis = q.IdEmpresa_dis,
                                IdSucursal_dis = q.IdSucursal_dis,
                                IdMovi_inven_tipo_dis = q.IdMovi_inven_tipo_dis,
                                IdNumMovi_dis = q.IdNumMovi_dis,
                                estado = q.estado,
                                signo = q.signo,
                            }).FirstOrDefault();
                }

                return info;
            }
            catch (Exception )
            {
                                throw;

            }
        }

        public List<in_Ing_Egr_Inven_distribucion_Info> get_list_x_distribuir(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo, decimal IdNumMovi)
        {
            try
            {
                List<in_Ing_Egr_Inven_distribucion_Info> Lista = new List<in_Ing_Egr_Inven_distribucion_Info>();

                using (Entities_inventario Context = new Entities_inventario())
                {
                    Lista = (from q in Context.vwin_Ing_Egr_Inven_distribucion_x_distribuir

                             join c in Context.in_categorias
                             on new {q.IdEmpresa,q.IdCategoria} equals new{c.IdEmpresa,c.IdCategoria }
                             join p in Context.in_presentacion
                             on new { q.IdEmpresa, q.IdPresentacion } equals new { p.IdEmpresa, p.IdPresentacion }
                             where q.IdEmpresa == IdEmpresa
                             && q.IdSucursal == IdSucursal
                             && q.IdMovi_inven_tipo == IdMovi_inven_tipo
                             && q.IdNumMovi == IdNumMovi
                             select new in_Ing_Egr_Inven_distribucion_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdMovi_inven_tipo = q.IdMovi_inven_tipo,
                                 IdNumMovi = q.IdNumMovi,
                                 signo = q.signo,
                                 IdProducto = q.IdProducto,
                                 IdProducto_padre = q.IdProducto_padre,
                                 pr_descripcion = q.pr_descripcion+"  "+p.nom_presentacion+" "+c.ca_Categoria,
                                 IdUnidadMedida = q.IdUnidadMedida,
                                 can_total = q.can_total,
                                 can_distribuida = q.can_distribuida,
                                 can_x_distribuir = q.can_x_distribuir,
                                 

                             }).ToList();
                }

                return Lista;
            }
            catch (Exception )
            {
                throw;

            }
        }

        public List<in_Ing_Egr_Inven_distribucion_Info> get_list_distribuido(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo, decimal IdNumMovi)
        {
            try
            {
                List<in_Ing_Egr_Inven_distribucion_Info> Lista = new List<in_Ing_Egr_Inven_distribucion_Info>();

                using (Entities_inventario Context = new Entities_inventario())
                {
                    Lista = (from q in Context.vwin_Ing_Egr_Inven_distribucion_det
                             where q.IdEmpresa == IdEmpresa
                             && q.IdSucursal == IdSucursal
                             && q.IdMovi_inven_tipo == IdMovi_inven_tipo
                             && q.IdNumMovi == IdNumMovi
                             select new in_Ing_Egr_Inven_distribucion_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdMovi_inven_tipo = q.IdMovi_inven_tipo,
                                 IdNumMovi = q.IdNumMovi,

                                 IdProducto = q.IdProducto,
                                 IdProducto_padre = q.IdProducto_padre,
                                 pr_descripcion = q.pr_descripcion,
                                 IdUnidadMedida = q.IdUnidadMedida,

                                 dm_cantidad = q.dm_cantidad,
                                 mv_costo = q.mv_costo,
                                 lote_fecha_vcto=q.lote_fecha_vcto,
                                 lote_num_lote=q.lote_num_lote
                                 
                             }).ToList();
                }
                int idsecuencia = 1;
                foreach (var item in Lista)
                {
                    item.secuencia_distribucion = idsecuencia;
                    idsecuencia++;
                    item.pr_descripcion = item.pr_descripcion+ "  "+item.lote_num_lote+"  "+((item.lote_fecha_vcto)==null?"": Convert.ToDateTime(item.lote_fecha_vcto).ToString("dd/MM/yyyy"));
                }
                return Lista;
            }
            catch (Exception e)
            {
                throw;

            }
        }

        public List<in_Ing_Egr_Inven_distribucion_Info> get_list(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo)
        {
            try
            {
                List<in_Ing_Egr_Inven_distribucion_Info> Lista = new List<in_Ing_Egr_Inven_distribucion_Info>();

                int IdSucursal_ini = IdSucursal;
                int IdSucursal_fin = IdSucursal == 0 ? 9999 : IdSucursal;

                int IdMovi_inven_tipo_ini = IdMovi_inven_tipo;
                int IdMovi_inven_tipo_fin = IdMovi_inven_tipo == 0 ? 9999 : IdMovi_inven_tipo;

                using (Entities_inventario Context = new Entities_inventario())
                {
                    Lista = (from q in Context.vwin_Ing_Egr_Inven_distribucion
                             where q.IdEmpresa == IdEmpresa
                             && IdSucursal_ini <= q.IdSucursal && q.IdSucursal <= IdSucursal_fin
                             && IdMovi_inven_tipo_ini <= q.IdMovi_inven_tipo && q.IdMovi_inven_tipo <= IdMovi_inven_tipo_fin
                             select new in_Ing_Egr_Inven_distribucion_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdMovi_inven_tipo = q.IdMovi_inven_tipo,
                                 IdNumMovi = q.IdNumMovi,
                                 signo = q.signo,
                                 can_total = q.can_total,
                                 can_distribuida = q.can_distribuida,
                                 can_x_distribuir = q.can_x_distribuir,
                                 cm_observacion = q.cm_observacion,
                                 cm_fecha = q.cm_fecha,
                                 tm_descripcion = q.tm_descripcion,
                                 Su_Descripcion = q.Su_Descripcion,
                                 IdBodega = q.IdBodega,

                                 pe_nombreCompleto = q.pe_nombreCompleto,
                                 vt_NumFactura = q.vt_NumFactura
                             }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public List<in_Ing_Egr_Inven_distribucion_Info> get_list(int IdEmpresa, DateTime FechaInicio, DateTime FechaFin)
        {
            try
            {
                FechaInicio = Convert.ToDateTime(FechaInicio.ToShortDateString());
                FechaFin = Convert.ToDateTime(FechaFin.ToShortDateString());

                List<in_Ing_Egr_Inven_distribucion_Info> Lista = new List<in_Ing_Egr_Inven_distribucion_Info>();

                using (Entities_inventario Context = new Entities_inventario())
                {
                    Lista = (from q in Context.vwin_Ing_Egr_Inven_distribucion

                             where q.IdEmpresa == IdEmpresa
                             && q.cm_fecha>=FechaInicio
                             && q.cm_fecha<=FechaFin
                             select new in_Ing_Egr_Inven_distribucion_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdMovi_inven_tipo = q.IdMovi_inven_tipo,
                                 IdNumMovi = q.IdNumMovi,
                                 signo = q.signo,
                                 can_total = q.can_total,
                                 can_distribuida = q.can_distribuida,
                                 can_x_distribuir = q.can_x_distribuir,
                                 cm_observacion = q.cm_observacion,
                                 cm_fecha = q.cm_fecha,
                                 tm_descripcion = q.tm_descripcion,
                                 Su_Descripcion = q.Su_Descripcion,
                                 IdBodega = q.IdBodega,
                                 estado = true,
                                 pe_nombreCompleto = q.pe_nombreCompleto,
                                 vt_NumFactura = q.vt_NumFactura
                             }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        private int get_id(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo, decimal IdNumMovi)
        {
            try
            {
                int ID = 1;

                using (Entities_inventario Context = new Entities_inventario())
                {
                    var lst = from q in Context.in_Ing_Egr_Inven_distribucion
                              where q.IdEmpresa == IdEmpresa
                              && q.IdSucursal == IdSucursal
                              && q.IdMovi_inven_tipo == IdMovi_inven_tipo
                              && q.IdNumMovi == IdNumMovi
                              select q;

                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.secuencia_distribucion) + 1;
                }

                return ID;
            }
            catch (Exception )
            {
                throw;

            }
        }

        public bool guardarDB(in_Ing_Egr_Inven_distribucion_Info info)
        {
            try
            {
                using (Entities_inventario Context = new Entities_inventario())
                {

                    in_Ing_Egr_Inven_distribucion Entity = new in_Ing_Egr_Inven_distribucion();
                    Entity.IdEmpresa = info.IdEmpresa;
                    Entity.IdSucursal = info.IdSucursal;
                    Entity.IdMovi_inven_tipo = info.IdMovi_inven_tipo;
                    Entity.IdNumMovi = info.IdNumMovi;
                    Entity.secuencia_distribucion = info.secuencia_distribucion = get_id(info.IdEmpresa, info.IdSucursal, info.IdMovi_inven_tipo, info.IdNumMovi);
                    Entity.IdEmpresa_dis = info.IdEmpresa_dis;
                    Entity.IdSucursal_dis = info.IdSucursal_dis;
                    Entity.IdMovi_inven_tipo_dis = info.IdMovi_inven_tipo_dis;
                    Entity.IdNumMovi_dis = info.IdNumMovi_dis;
                    Entity.estado = info.estado;
                    Entity.signo = info.signo;
                    Context.in_Ing_Egr_Inven_distribucion.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception )
            {
                throw;

            }
        }

        public bool guardarDB(List<in_Ing_Egr_Inven_distribucion_Info> lista)
        {
            try
            {
                foreach (var item in lista)
                {
                    guardarDB(item);
                }

                return true;
            }
            catch (Exception )
            {
                throw;

            }
        }

        public bool eliminarDB(int IdEmpresa, int IdSucursal, int IdMovi_inven_tipo, int IdNumMovi)
        {
            try
            {
                using (Entities_inventario Context = new Entities_inventario())
                {
                    Context.Database.ExecuteSqlCommand("DELETE in_Ing_Egr_Inven_distribucion where IdEmpresa = " + IdEmpresa + " and IdSucursal = " + IdSucursal + " and IdMovi_inven_tipo = " + IdMovi_inven_tipo + " and IdNumMovi = " + IdNumMovi);
                    return true;
                }
            }
            catch (Exception )
            {
                throw;

            }
        }
    }
}
