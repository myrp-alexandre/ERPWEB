using Core.Erp.Info.ActivoFijo;
using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.ActivoFijo
{
   public class Af_Activo_fijo_Data
    {

        public List<Af_Activo_fijo_Info> get_list_bajo_demanda(ListEditItemsRequestedByFilterConditionEventArgs args, int IdEmpresa)
        {
            var skip = args.BeginIndex;
            var take = args.EndIndex - args.BeginIndex + 1;
            List<Af_Activo_fijo_Info> Lista = new List<Af_Activo_fijo_Info>();
            Lista = get_list(IdEmpresa, skip, take, args.Filter);
            return Lista;
        }

        public Af_Activo_fijo_Info get_info_bajo_demanda(int IdEmpresa, ListEditItemRequestedByValueEventArgs args)
        {
            decimal id;
            if (args.Value == null || !decimal.TryParse(args.Value.ToString(), out id))
                return null;
            return get_info_demanda(IdEmpresa, (int)args.Value);
        }

        public List<Af_Activo_fijo_Info> get_list(int IdEmpresa, int skip, int take, string filter)
        {
            try
            {
                List<Af_Activo_fijo_Info> Lista = new List<Af_Activo_fijo_Info>();

                Entities_activo_fijo context_g = new Entities_activo_fijo();

                var lstg = context_g.Af_Activo_fijo.Where(q => q.Estado == "A" && q.IdEmpresa == IdEmpresa && (q.IdActivoFijo.ToString() + " " + q.Af_Nombre).Contains(filter)).OrderBy(q => q.IdSucursal).Skip(skip).Take(take);
                foreach (var q in lstg)
                {
                    Lista.Add(new Af_Activo_fijo_Info
                    {
                        IdSucursal = q.IdSucursal,
                        CodActivoFijo = q.CodActivoFijo,
                        Af_Nombre = q.Af_Nombre
                    });
                }

                context_g.Dispose();
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public Af_Activo_fijo_Info get_info_demanda(int IdEmpresa, int value)
        {
            Af_Activo_fijo_Info info = new Af_Activo_fijo_Info();
            using (Entities_activo_fijo Contex = new Entities_activo_fijo())
            {
                info = (from q in Contex.Af_Activo_fijo
                        where q.IdEmpresa == IdEmpresa
                        && q.IdActivoFijo==value
                        select new Af_Activo_fijo_Info
                        {
                            IdSucursal = q.IdSucursal,
                            CodActivoFijo = q.CodActivoFijo,
                            Af_Nombre = q.Af_Nombre
                        }).FirstOrDefault();
            }
            return info;
        }


        public List<Af_Activo_fijo_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                List<Af_Activo_fijo_Info> Lista;
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    if (mostrar_anulados)
                        Lista = (from q in Context.Af_Activo_fijo
                                 join c in Context.Af_Catalogo
                                 on q.Estado_Proceso equals c.IdCatalogo
                                 where q.IdEmpresa == IdEmpresa
                                 select new Af_Activo_fijo_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     Estado = q.Estado,
                                     Af_Nombre = q.Af_Nombre,
                                     IdActivoFijo = q.IdActivoFijo,
                                     Estado_Proceso = q.Estado_Proceso,
                                     Estado_Proceso_nombre = c.Descripcion,

                                     EstadoBool = q.Estado == "A" ? true : false

                                 }).ToList();
                    else
                        Lista = (from q in Context.Af_Activo_fijo
                                 join c in Context.Af_Catalogo
                                 on q.Estado_Proceso equals c.IdCatalogo
                                 where q.IdEmpresa == IdEmpresa
                                 && q.Estado == "A"
                                 select new Af_Activo_fijo_Info
                                 {                                     
                                     IdEmpresa = q.IdEmpresa,
                                     Af_Nombre = q.Af_Nombre,
                                     Estado = q.Estado,
                                     IdActivoFijo = q.IdActivoFijo,
                                     Estado_Proceso = q.Estado_Proceso,
                                     Estado_Proceso_nombre = c.Descripcion,

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

        public Af_Activo_fijo_Info get_info(int IdEmpresa, int IdActivoFijo)
        {
            try
            {
                Af_Activo_fijo_Info info = new Af_Activo_fijo_Info();
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    Af_Activo_fijo Entity = Context.Af_Activo_fijo.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdActivoFijo == IdActivoFijo);
                    if (Entity == null) return null;
                    info = new Af_Activo_fijo_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        Af_Codigo_Barra = Entity.Af_Codigo_Barra,
                        Af_costo_compra = Entity.Af_costo_compra,
                        Af_Depreciacion_acum = Entity.Af_Depreciacion_acum,
                        Af_fecha_compra = Entity.Af_fecha_compra,
                        Af_fecha_fin_depre = Entity.Af_fecha_fin_depre,
                        Af_fecha_ini_depre = Entity.Af_fecha_ini_depre,
                        Af_Meses_depreciar = Entity.Af_Meses_depreciar,
                        Af_Nombre = Entity.Af_Nombre,
                        Af_NumPlaca = Entity.Af_NumPlaca,
                        Af_NumSerie = Entity.Af_NumSerie,
                        Af_observacion = Entity.Af_observacion,
                        Af_porcentaje_deprec = Entity.Af_porcentaje_deprec,
                        Af_Vida_Util = Entity.Af_Vida_Util,
                        CodActivoFijo = Entity.CodActivoFijo,
                        Af_ValorSalvamento = Entity.Af_ValorSalvamento,
                        Estado = Entity.Estado,
                        Estado_Proceso = Entity.Estado_Proceso,
                        IdActivoFijoTipo = Entity.IdActivoFijoTipo,
                        IdActivoFijo = Entity.IdActivoFijo,
                        IdCatalogo_Color = Entity.IdCatalogo_Color,
                        IdCatalogo_Marca = Entity.IdCatalogo_Marca,
                        IdCatalogo_Modelo = Entity.IdCatalogo_Modelo,
                        IdCategoriaAF = Entity.IdCategoriaAF,
                        IdSucursal = Entity.IdSucursal,
                        IdTipoCatalogo_Ubicacion = Entity.IdTipoCatalogo_Ubicacion,
                        IdEmpleadoCustodio = Entity.IdEmpleadoCustodio,
                        IdEmpleadoEncargado = Entity.IdEmpleadoEncargado,
                        Estado_Proceso_nombre = Entity.Estado_Proceso,
                        IdDepartamento = Entity.IdDepartamento
                        

                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public int get_id(int IdEmpresa)
        {
            try
            {
                int ID = 1;
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    var lst = from q in Context.Af_Activo_fijo
                              where q.IdEmpresa == IdEmpresa
                              select q;
                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdActivoFijo) + 1;
                }
                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(Af_Activo_fijo_Info info)
        {
            try
            {
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    Af_Activo_fijo Entity = new Af_Activo_fijo
                    {
                        IdEmpresa = info.IdEmpresa,
                        Af_Codigo_Barra = info.Af_Codigo_Barra,
                        Af_costo_compra = info.Af_costo_compra,
                        Af_Depreciacion_acum = info.Af_Depreciacion_acum,
                        Af_fecha_compra = info.Af_fecha_compra.Date,
                        Af_fecha_fin_depre = info.Af_fecha_fin_depre.Date,
                        Af_fecha_ini_depre = info.Af_fecha_ini_depre.Date,
                        Af_Meses_depreciar = info.Af_Meses_depreciar,
                        Af_Nombre = info.Af_Nombre,
                        Af_NumPlaca = info.Af_NumPlaca,
                        Af_NumSerie = info.Af_NumSerie,
                        Af_observacion = info.Af_observacion,
                        Af_porcentaje_deprec = info.Af_porcentaje_deprec,
                        Af_ValorSalvamento = info.Af_ValorSalvamento,
                        Af_Vida_Util = info.Af_Vida_Util,
                        CodActivoFijo = info.CodActivoFijo,
                        Estado = info.Estado="A",
                        Estado_Proceso = info.Estado_Proceso,
                        IdActivoFijoTipo = info.IdActivoFijoTipo,
                        IdActivoFijo = info.IdActivoFijo=get_id(info.IdEmpresa),
                        IdCatalogo_Color = info.IdCatalogo_Color,
                        IdCatalogo_Marca = info.IdCatalogo_Marca,
                        IdCatalogo_Modelo = info.IdCatalogo_Modelo,
                        IdCategoriaAF = info.IdCategoriaAF,
                        IdSucursal = info.IdSucursal,
                        IdTipoCatalogo_Ubicacion = info.IdTipoCatalogo_Ubicacion,
                        IdEmpleadoCustodio = info.IdEmpleadoCustodio,
                        IdEmpleadoEncargado = info.IdEmpleadoEncargado,
                        IdDepartamento = info.IdDepartamento,
                        IdUsuario = info.IdUsuario,
                        Fecha_Transac = DateTime.Now                                                
                    };
                    if (info.LstDet.Count > 0)
                    {
                        foreach (var item in info.LstDet)
                        {
                            Context.Af_Activo_fijo_CtaCble.Add(new Af_Activo_fijo_CtaCble
                            {
                                IdActivoFijo = info.IdActivoFijo,
                                IdDepartamento = item.IdDepartamento,
                                IdCtaCble = item.IdCtaCble,
                                Porcentaje = item.Porcentaje,
                                Secuencia = item.Secuencia,
                                IdEmpresa = info.IdEmpresa

                            });
                        }
                    }
                    Context.Af_Activo_fijo.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(Af_Activo_fijo_Info info)
        {
            try
            {
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    Af_Activo_fijo Entity = Context.Af_Activo_fijo.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdActivoFijo == info.IdActivoFijo);
                    if (Entity == null) return false;
                    
                    Entity.Af_Codigo_Barra = info.Af_Codigo_Barra;
                    Entity.Af_costo_compra = info.Af_costo_compra;
                    Entity.Af_Depreciacion_acum = info.Af_Depreciacion_acum;
                    Entity.Af_fecha_compra = info.Af_fecha_compra.Date;
                    Entity.Af_fecha_fin_depre = info.Af_fecha_fin_depre.Date;
                    Entity.Af_fecha_ini_depre = info.Af_fecha_ini_depre.Date;
                    Entity.Af_Meses_depreciar = info.Af_Meses_depreciar;
                    Entity.Af_Nombre = info.Af_Nombre;
                    Entity.Af_NumPlaca = info.Af_NumPlaca;
                    Entity.Af_NumSerie = info.Af_NumSerie;
                    Entity.Af_observacion = info.Af_observacion;
                    Entity.Af_porcentaje_deprec = info.Af_porcentaje_deprec;
                    Entity.Af_ValorSalvamento = info.Af_ValorSalvamento;
                    Entity.Af_Vida_Util = info.Af_Vida_Util;
                    Entity.CodActivoFijo = info.CodActivoFijo;
                    Entity.Estado_Proceso = info.Estado_Proceso;
                    Entity.IdActivoFijoTipo = info.IdActivoFijoTipo;
                    Entity.IdCatalogo_Color = info.IdCatalogo_Color;
                    Entity.IdCatalogo_Marca = info.IdCatalogo_Marca;
                    Entity.IdCatalogo_Modelo = info.IdCatalogo_Modelo;
                    Entity.IdCategoriaAF = info.IdCategoriaAF;
                    Entity.IdSucursal = info.IdSucursal;
                    Entity.IdTipoCatalogo_Ubicacion = info.IdTipoCatalogo_Ubicacion;
                    Entity.IdEmpleadoCustodio = info.IdEmpleadoCustodio;
                    Entity.IdEmpleadoEncargado = info.IdEmpleadoEncargado;
                    Entity.IdDepartamento = info.IdDepartamento;

                    var detalle = Context.Af_Activo_fijo_CtaCble.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdActivoFijo == info.IdActivoFijo);
                    Context.Af_Activo_fijo_CtaCble.RemoveRange(detalle);
                    if (info.LstDet.Count > 0)
                    {
                        foreach (var item in info.LstDet)
                        {
                            Context.Af_Activo_fijo_CtaCble.Add(new Af_Activo_fijo_CtaCble
                            {
                                IdActivoFijo = info.IdActivoFijo,
                                IdDepartamento = item.IdDepartamento,
                                IdCtaCble = item.IdCtaCble,
                                Porcentaje = item.Porcentaje,
                                Secuencia = item.Secuencia,
                                IdEmpresa = info.IdEmpresa

                            });
                        }
                    }
                    Entity.IdUsuarioUltMod = info.IdUsuarioUltMod;
                    Entity.Fecha_UltMod = DateTime.Now;
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception e)
            {

                throw;
            }
        }

        public bool anularDB(Af_Activo_fijo_Info info)
        {
            try
            {
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    Af_Activo_fijo Entity = Context.Af_Activo_fijo.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdActivoFijo == info.IdActivoFijo);
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

        public Af_Activo_fijo_valores_Info get_valores(int IdEmpresa, int IdActivoFijo)
        {
            try
            {
                Af_Activo_fijo_valores_Info valores = new Af_Activo_fijo_valores_Info();
                double v_mejora = 0;
                double v_baja = 0;
                using (Entities_activo_fijo Context = new Entities_activo_fijo())
                {
                    Af_Activo_fijo Entity = Context.Af_Activo_fijo.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdActivoFijo == IdActivoFijo);
                    if (Entity == null) return null;

                    var mej_baj = from q in Context.Af_Mej_Baj_Activo
                                  where q.IdEmpresa == IdEmpresa
                                  && q.IdActivoFijo == IdActivoFijo
                                  select q;

                    if (mej_baj.Where(q=>q.Id_Tipo == "Mejo_Acti").Count() > 0)
                        v_mejora = mej_baj.Where(q => q.Id_Tipo == "Mejo_Acti").Sum(m => m.Valor_Mej_Baj_Activo);

                    if (mej_baj.Where(q => q.Id_Tipo == "Baja_Acti").Count() > 0)
                        v_baja = mej_baj.Where(q => q.Id_Tipo == "Baja_Acti").Sum(m => m.Valor_Mej_Baj_Activo);

                    valores = new Af_Activo_fijo_valores_Info
                    {
                        v_activo = Entity.Af_costo_compra,
                        v_depr_acum = Entity.Af_Depreciacion_acum,
                        v_baja = 0,
                        v_mejora = 0,
                        v_neto = Entity.Af_costo_compra - Entity.Af_Depreciacion_acum + v_mejora - v_baja
                    };
                }
                return valores;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
